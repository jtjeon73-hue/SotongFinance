import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_finance/core/utils/finance_math.dart';

void main() {
  group('FinanceMath.netWorth', () {
    test('assets minus liabilities', () {
      expect(
        FinanceMath.netWorth(assets: 100000000, liabilities: 30000000),
        70000000,
      );
    });
    test('negative net worth', () {
      expect(FinanceMath.netWorth(assets: 1000, liabilities: 5000), -4000);
    });
  });

  group('FinanceMath.monthlyCashFlow', () {
    test('positive', () {
      expect(
        FinanceMath.monthlyCashFlow(income: 3000000, expenses: 2500000),
        500000,
      );
    });
  });

  group('FinanceMath.savingsRate', () {
    test('20 percent', () {
      expect(FinanceMath.savingsRate(income: 4000000, savings: 800000), 20);
    });
    test('zero income throws', () {
      expect(
        () => FinanceMath.savingsRate(income: 0, savings: 100),
        throwsArgumentError,
      );
    });
  });

  group('FinanceMath.simpleInterest', () {
    test('known example', () {
      // 10,000,000 * (1 + 0.03 * 2) = 10,600,000
      expect(
        FinanceMath.simpleInterest(
          principal: 10000000,
          annualRatePercent: 3,
          years: 2,
        ),
        10600000,
      );
    });
  });

  group('FinanceMath.compoundInterest', () {
    test('annual compound', () {
      final r = FinanceMath.compoundInterest(
        principal: 10000000,
        annualRatePercent: 5,
        years: 10,
        compoundsPerYear: 1,
      );
      // 10000000 * (1.05)^10 ≈ 16288946.27
      expect(r, closeTo(16288946.27, 0.1));
    });
    test('invalid n throws', () {
      expect(
        () => FinanceMath.compoundInterest(
          principal: 100,
          annualRatePercent: 5,
          years: 1,
          compoundsPerYear: 0,
        ),
        throwsArgumentError,
      );
    });
  });

  group('FinanceMath.realReturnPercent', () {
    test('approx Fisher', () {
      final r = FinanceMath.realReturnPercent(
        nominalPercent: 5,
        inflationPercent: 2,
      );
      // (1.05/1.02)-1 ≈ 2.941%
      expect(r, closeTo(2.941176, 0.001));
    });
  });

  group('FinanceMath.equalPaymentMonthly', () {
    test('zero rate', () {
      expect(
        FinanceMath.equalPaymentMonthly(
          principal: 1200000,
          annualRatePercent: 0,
          months: 12,
        ),
        100000,
      );
    });
    test('known 4% 30y approx', () {
      final m = FinanceMath.equalPaymentMonthly(
        principal: 100000000,
        annualRatePercent: 4,
        months: 360,
      );
      // Cross-check: roughly 477,415
      expect(m, closeTo(477415.23, 1));
    });
    test('invalid months', () {
      expect(
        () => FinanceMath.equalPaymentMonthly(
          principal: 100,
          annualRatePercent: 4,
          months: 0,
        ),
        throwsArgumentError,
      );
    });
  });

  group('FinanceMath.equalPrincipal', () {
    test('total interest formula', () {
      final interest = FinanceMath.equalPrincipalTotalInterest(
        principal: 50000000,
        annualRatePercent: 5,
        months: 60,
      );
      // 50e6 * (0.05/12) * 61/2 = 6,354,166.67
      expect(interest, closeTo(6354166.666, 0.1));
    });
    test('first payment', () {
      final first = FinanceMath.equalPrincipalFirstPayment(
        principal: 1200000,
        annualRatePercent: 12,
        months: 12,
      );
      // principal 100000 + interest 12000 = 112000
      expect(first, 112000);
    });
  });

  group('FinanceMath.investmentReturnPercent', () {
    test('gain', () {
      expect(
        FinanceMath.investmentReturnPercent(
          buyAmount: 1000000,
          sellAmount: 1100000,
        ),
        10,
      );
    });
    test('loss', () {
      expect(
        FinanceMath.investmentReturnPercent(
          buyAmount: 1000000,
          sellAmount: 900000,
        ),
        -10,
      );
    });
    test('zero buy throws', () {
      expect(
        () =>
            FinanceMath.investmentReturnPercent(buyAmount: 0, sellAmount: 100),
        throwsArgumentError,
      );
    });
  });

  group('FinanceMath.rentalYieldPercent', () {
    test('3 percent', () {
      expect(
        FinanceMath.rentalYieldPercent(
          annualRent: 6000000,
          purchasePrice: 200000000,
        ),
        3,
      );
    });
  });

  group('FinanceMath.retirementGap', () {
    test('shortage', () {
      expect(
        FinanceMath.retirementGap(
          neededTotal: 500000000,
          expectedAssets: 350000000,
        ),
        150000000,
      );
    });
  });

  group('FinanceMath.pensionMonthlySum', () {
    test('sum', () {
      expect(
        FinanceMath.pensionMonthlySum([500000, 300000, 200000, 0]),
        1000000,
      );
    });
  });

  group('FinanceMath.futureLivingCost', () {
    test('2% 20y', () {
      final r = FinanceMath.futureLivingCost(
        currentCost: 2000000,
        inflationPercent: 2,
        years: 20,
      );
      expect(r, closeTo(2971894.85, 1));
    });
  });

  group('FinanceMath.roundMoney', () {
    test('rounds', () {
      expect(FinanceMath.roundMoney(1234.6), 1235);
      expect(FinanceMath.roundMoney(1234.56, digits: 1), 1234.6);
    });
  });
}
