import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_finance/core/utils/finance_math.dart';
import 'package:sotong_finance/core/utils/freshness.dart';
import 'package:sotong_finance/data/calculator_catalog.dart';
import 'package:sotong_finance/data/content_catalog.dart';
import 'package:sotong_finance/data/content_quality_data.dart';
import 'package:sotong_finance/data/life_path_data.dart';
import 'package:sotong_finance/data/phase2_overrides.dart';
import 'package:sotong_finance/data/phase2_upgraded_ids.dart';
import 'package:sotong_finance/data/prompt_data.dart';
import 'package:sotong_finance/data/source_data.dart';
import 'package:sotong_finance/models/content_quality.dart';
import 'package:sotong_finance/models/enums.dart';
import 'package:sotong_finance/services/diagnosis_service.dart';

void main() {
  test('phase2 overrides cover upgraded ids', () {
    assertPhase2OverridesComplete();
    expect(phase2UpgradedIds.length, inInclusiveRange(36, 55));
    for (final id in phase2UpgradedIds) {
      expect(getById(id), isNotNull, reason: id);
      expect(gradeFor(id), ContentQualityGrade.a);
    }
  });

  test('quality grades counted without auto-A for remainder', () {
    final counts = countByGrade();
    expect(
      counts[ContentQualityGrade.a],
      greaterThanOrEqualTo(phase2UpgradedIds.length),
    );
    expect(
      (counts[ContentQualityGrade.c] ?? 0) +
          (counts[ContentQualityGrade.d] ?? 0),
      greaterThan(30),
    );
    expect(allFinanceContent.length, 174);
  });

  test('life paths resolve content and calculators', () {
    expect(lifePaths.length, greaterThanOrEqualTo(12));
    for (final p in lifePaths) {
      expect(p.steps, isNotEmpty);
      for (final step in p.steps) {
        expect(step.contentIds, isNotEmpty);
        for (final id in step.contentIds) {
          expect(getById(id), isNotNull, reason: '${p.id} -> $id');
        }
      }
    }
  });

  test('diagnosis is local educational and non-judgmental', () {
    final r = runDiagnosis(
      const DiagnosisInput(
        monthlyIncome: 400,
        monthlyEssential: 200,
        monthlyTotalExpense: 300,
        cashLike: 600,
        totalAssets: 5000,
        totalLiabilities: 1000,
        monthlyDebtPayment: 50,
        monthlyPensionSum: 100,
        yearsToRetire: 20,
      ),
    );
    expect(r.cashFlow, 100);
    expect(r.netWorth, 4000);
    expect(r.notes.any((n) => n.contains('단정하지 않습니다')), isTrue);
    expect(r.notes.any((n) => n.contains('서버에 저장되지 않습니다')), isTrue);
  });

  test('freshness labels', () {
    expect(
      freshnessFor(
        reviewDueAt: '2099-01-01',
        verificationStatusName: 'verified',
      ),
      FreshnessLabel.upToDate,
    );
    expect(
      freshnessFor(
        reviewDueAt: '2020-01-01',
        verificationStatusName: 'verified',
      ),
      FreshnessLabel.needsReview,
    );
    expect(
      freshnessFor(
        reviewDueAt: '2099-01-01',
        verificationStatusName: 'officialCalculatorRecommended',
      ),
      FreshnessLabel.officialCalculator,
    );
  });

  test('phase2 calculators formulas run', () {
    expect(
      runCalculator('calc-emergency-months', {
        'cash': 600.0,
        'essential': 200.0,
      })!.summary,
      contains('3'),
    );
    expect(
      runCalculator('calc-recovery', {'loss': 50.0})!.summary,
      contains('100'),
    );
    expect(
      FinanceMath.etfCostDragFutureValue(
        principal: 10000000,
        years: 10,
        grossReturnPercent: 5,
        feePercent: 0.5,
      ),
      lessThan(
        FinanceMath.compoundInterest(
          principal: 10000000,
          annualRatePercent: 5,
          years: 10,
          compoundsPerYear: 1,
        ),
      ),
    );
  });

  test('prompts expanded and sources expanded', () {
    expect(promptItems.length, inInclusiveRange(32, 60));
    expect(officialSources.length, greaterThanOrEqualTo(22));
    final statuses = officialSources.map((e) => e.verificationStatus).toSet();
    expect(statuses.contains(VerificationStatus.verified), isTrue);
    expect(statuses.contains(VerificationStatus.educationalExample), isTrue);
  });

  test('no invented absolute tax rate as unit answer in recovery formula', () {
    expect(
      FinanceMath.recoveryReturnPercent(lossPercent: 20),
      closeTo(25, 0.01),
    );
  });
}
