import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_finance/core/constants/app_constants.dart';
import 'package:sotong_finance/core/utils/finance_math.dart';
import 'package:sotong_finance/data/calculator_catalog.dart';
import 'package:sotong_finance/data/content_catalog.dart';
import 'package:sotong_finance/data/content_quality_data.dart';
import 'package:sotong_finance/data/crisis_data.dart';
import 'package:sotong_finance/data/finance_plan_data.dart';
import 'package:sotong_finance/data/ips_data.dart';
import 'package:sotong_finance/data/phase3_overrides.dart';
import 'package:sotong_finance/data/phase3_upgraded_ids.dart';
import 'package:sotong_finance/data/policy_timeline_data.dart';
import 'package:sotong_finance/data/prompt_data.dart';
import 'package:sotong_finance/data/scenario_data.dart';
import 'package:sotong_finance/models/content_quality.dart';
import 'package:sotong_finance/models/enums.dart';

void main() {
  test('phase3 overrides cover upgraded ids', () {
    assertPhase3OverridesComplete();
    expect(phase3UpgradedIds.length, inInclusiveRange(45, 60));
    for (final id in phase3UpgradedIds) {
      expect(getById(id), isNotNull, reason: id);
      expect(gradeFor(id), ContentQualityGrade.a);
    }
  });

  test('type-aware quality keeps remaining C/D', () {
    final counts = countByGrade();
    expect(counts[ContentQualityGrade.a], greaterThanOrEqualTo(100));
    expect(
      (counts[ContentQualityGrade.c] ?? 0) +
          (counts[ContentQualityGrade.d] ?? 0),
      greaterThan(20),
    );
    final kinds = countCdByKind();
    expect(kinds.values.fold<int>(0, (a, b) => a + b), greaterThan(20));
  });

  test('expert calculators and formulas', () {
    expect(calculatorCatalog.length, greaterThanOrEqualTo(37));
    expect(
      FinanceMath.concentrationPercent(focusAmount: 40, totalAssets: 100),
      40,
    );
    expect(
      FinanceMath.maxDrawdownPercent(peak: 100, trough: 70),
      closeTo(30, 0.01),
    );
    expect(
      FinanceMath.rebalanceTradeAmount(
        currentValue: 30,
        targetWeightPercent: 40,
        portfolioValue: 100,
      ),
      10,
    );
    final seq = runCalculator('calc-sequence-multi', {
      'start': 100.0,
      'r1': -20.0,
      'r2': 20.0,
      'wd': 10.0,
    });
    expect(seq, isNotNull);
    expect(seq!.summary.contains('순서'), isTrue);
  });

  test('ips finance plan crisis timeline populated', () {
    expect(ipsTemplateFields.length, greaterThanOrEqualTo(20));
    expect(financePlanSteps.length, 16);
    expect(crisisEvents.length, greaterThanOrEqualTo(7));
    expect(policyTimeline.length, greaterThanOrEqualTo(6));
    expect(policyTimeline.any((t) => t.status == 'draftUnconfirmed'), isTrue);
    final md = buildIpsMarkdown({'purpose': '교육용'});
    expect(md.contains('투자정책서'), isTrue);
  });

  test('prompts in phase3 range', () {
    expect(promptItems.length, inInclusiveRange(50, 60));
  });

  test('application validation statuses exist', () {
    expect(ApplicationValidationStatus.values.length, 6);
  });

  test('phase3 scenarios are deepened', () {
    expect(financialScenarios.length, greaterThanOrEqualTo(12));
    for (final s in financialScenarios) {
      expect(s.alternatives, isNotEmpty, reason: s.id);
      expect(s.stressTests, isNotEmpty, reason: s.id);
      expect(s.changeConditions, isNotEmpty, reason: s.id);
      expect(s.toMarkdown(), contains('스트레스 테스트'));
    }
  });

  test('privacy notices remain local-only', () {
    expect(AppConstants.noServerStorageNotice.contains('서버'), isTrue);
    expect(AppConstants.calculatorDisclaimer.contains('서버에 저장되지 않습니다'), isTrue);
  });
}
