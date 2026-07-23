import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_finance/core/utils/finance_math.dart';
import 'package:sotong_finance/data/calculator_catalog.dart';

void main() {
  group('boundary inputs via runCalculator', () {
    test('empty-like zeros for net worth', () {
      final r = runCalculator('calc-net-worth', {
        'assets': 0,
        'liabilities': 0,
      });
      expect(r, isNotNull);
      expect(r!.summary.contains('0'), isTrue);
    });

    test('negative net worth', () {
      final r = runCalculator('calc-net-worth', {
        'assets': 100,
        'liabilities': 250,
      });
      expect(r!.summary.contains('-150') || r.summary.contains('−'), isTrue);
    });

    test('savings rate zero income', () {
      final r = runCalculator('calc-savings-rate', {
        'income': 0,
        'savings': 10,
      });
      expect(r!.summary.contains('계산할 수 없습니다'), isTrue);
    });

    test('invest return zero buy', () {
      final r = runCalculator('calc-invest-return', {'buy': 0, 'sell': 100});
      expect(r!.summary.contains('계산할 수 없습니다'), isTrue);
    });

    test('loan months zero', () {
      final r = runCalculator('calc-loan-payment', {
        'principal': 1000000,
        'rate': 4,
        'months': 0,
      });
      expect(r!.summary.contains('계산할 수 없습니다'), isTrue);
    });

    test('compound invalid n', () {
      final r = runCalculator('calc-compound', {
        'principal': 1000,
        'rate': 5,
        'years': 1,
        'n': 0,
      });
      expect(r!.summary.contains('계산할 수 없습니다'), isTrue);
    });

    test('very large amount', () {
      final r = runCalculator('calc-simple', {
        'principal': 1e15,
        'rate': 1,
        'years': 1,
      });
      expect(r, isNotNull);
      expect(
        r!.summary.contains('Infinity') || r.summary.contains('NaN'),
        isFalse,
      );
    });

    test('decimal rates', () {
      final r = FinanceMath.realReturnPercent(
        nominalPercent: 5.25,
        inflationPercent: 2.1,
      );
      expect(r.isFinite, isTrue);
      expect(r, closeTo(3.08521, 0.01));
    });
  });

  group('cross-check known examples', () {
    test('compound 10y 5%', () {
      final r = FinanceMath.compoundInterest(
        principal: 10000000,
        annualRatePercent: 5,
        years: 10,
        compoundsPerYear: 1,
      );
      expect(r, closeTo(16288946.27, 0.1));
    });

    test('equal payment 1e8 4% 360m', () {
      final m = FinanceMath.equalPaymentMonthly(
        principal: 100000000,
        annualRatePercent: 4,
        months: 360,
      );
      expect(m, closeTo(477415.23, 1));
    });

    test('real return 5% / 2%', () {
      final r = FinanceMath.realReturnPercent(
        nominalPercent: 5,
        inflationPercent: 2,
      );
      expect(r, closeTo(2.941176, 0.001));
    });

    test('future cost 2% 20y', () {
      final r = FinanceMath.futureLivingCost(
        currentCost: 2000000,
        inflationPercent: 2,
        years: 20,
      );
      expect(r, closeTo(2971894.85, 1));
    });
  });

  test('all 14 calculators respond', () {
    expect(calculatorCatalog.length, greaterThanOrEqualTo(27));
    for (final c in calculatorCatalog) {
      final values = <String, double>{};
      for (final f in c.fields) {
        values[f.key] = f.defaultValue.isEmpty
            ? 1
            : double.tryParse(f.defaultValue) ?? 1;
      }
      // provide safer defaults for known keys
      values.putIfAbsent('months', () => 12);
      values.putIfAbsent('n', () => 1);
      values.putIfAbsent('income', () => 100);
      values.putIfAbsent('buy', () => 100);
      values.putIfAbsent('price', () => 100);
      final r = runCalculator(c.id, values);
      expect(r, isNotNull, reason: c.id);
      expect(r!.copyText.contains('Infinity'), isFalse, reason: c.id);
    }
  });
}
