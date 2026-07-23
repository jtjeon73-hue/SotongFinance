import 'dart:math' as math;

/// 교육용 금융 계산 수식 모음 (서버 저장 없음)
class FinanceMath {
  FinanceMath._();

  static double netWorth({
    required double assets,
    required double liabilities,
  }) => assets - liabilities;

  static double monthlyCashFlow({
    required double income,
    required double expenses,
  }) => income - expenses;

  static double savingsRate({required double income, required double savings}) {
    if (income == 0) {
      throw ArgumentError('소득은 0이 될 수 없습니다.');
    }
    return (savings / income) * 100;
  }

  /// 단리: A = P * (1 + r * t)
  static double simpleInterest({
    required double principal,
    required double annualRatePercent,
    required double years,
  }) {
    final r = annualRatePercent / 100;
    return principal * (1 + r * years);
  }

  static double simpleInterestEarned({
    required double principal,
    required double annualRatePercent,
    required double years,
  }) =>
      simpleInterest(
        principal: principal,
        annualRatePercent: annualRatePercent,
        years: years,
      ) -
      principal;

  /// 복리: A = P * (1 + r/n)^(n*t)
  static double compoundInterest({
    required double principal,
    required double annualRatePercent,
    required double years,
    int compoundsPerYear = 1,
  }) {
    if (compoundsPerYear <= 0) {
      throw ArgumentError('복리 횟수는 1 이상이어야 합니다.');
    }
    final r = annualRatePercent / 100;
    return principal *
        math.pow(1 + r / compoundsPerYear, compoundsPerYear * years);
  }

  /// 실질수익률 ≈ (1+명목)/(1+물가) - 1
  static double realReturnPercent({
    required double nominalPercent,
    required double inflationPercent,
  }) {
    final nominal = nominalPercent / 100;
    final inflation = inflationPercent / 100;
    if (inflation <= -1) {
      throw ArgumentError('물가상승률이 -100% 이하면 계산할 수 없습니다.');
    }
    return ((1 + nominal) / (1 + inflation) - 1) * 100;
  }

  /// 원리금균등 월상환액
  static double equalPaymentMonthly({
    required double principal,
    required double annualRatePercent,
    required int months,
  }) {
    if (months <= 0) throw ArgumentError('기간(개월)은 1 이상이어야 합니다.');
    if (principal < 0) throw ArgumentError('원금은 음수일 수 없습니다.');
    final monthlyRate = annualRatePercent / 100 / 12;
    if (monthlyRate == 0) return principal / months;
    final factor = math.pow(1 + monthlyRate, months);
    return principal * monthlyRate * factor / (factor - 1);
  }

  /// 원리금균등 총이자
  static double equalPaymentTotalInterest({
    required double principal,
    required double annualRatePercent,
    required int months,
  }) {
    final monthly = equalPaymentMonthly(
      principal: principal,
      annualRatePercent: annualRatePercent,
      months: months,
    );
    return monthly * months - principal;
  }

  /// 원금균등 첫 달 상환액
  static double equalPrincipalFirstPayment({
    required double principal,
    required double annualRatePercent,
    required int months,
  }) {
    if (months <= 0) throw ArgumentError('기간(개월)은 1 이상이어야 합니다.');
    final principalPart = principal / months;
    final interest = principal * (annualRatePercent / 100 / 12);
    return principalPart + interest;
  }

  /// 원금균등 총이자
  static double equalPrincipalTotalInterest({
    required double principal,
    required double annualRatePercent,
    required int months,
  }) {
    if (months <= 0) throw ArgumentError('기간(개월)은 1 이상이어야 합니다.');
    final monthlyRate = annualRatePercent / 100 / 12;
    // 합계 = 원금 * 월이율 * (n+1)/2
    return principal * monthlyRate * (months + 1) / 2;
  }

  static double investmentReturnPercent({
    required double buyAmount,
    required double sellAmount,
  }) {
    if (buyAmount == 0) throw ArgumentError('매수금액은 0이 될 수 없습니다.');
    return ((sellAmount - buyAmount) / buyAmount) * 100;
  }

  /// 단순 임대수익률(%) = 연임대소득 / 매입가 * 100
  static double rentalYieldPercent({
    required double annualRent,
    required double purchasePrice,
  }) {
    if (purchasePrice == 0) throw ArgumentError('매입가는 0이 될 수 없습니다.');
    return (annualRent / purchasePrice) * 100;
  }

  /// 은퇴자금 부족액 = 필요총액 - 예상자산
  static double retirementGap({
    required double neededTotal,
    required double expectedAssets,
  }) => neededTotal - expectedAssets;

  static double pensionMonthlySum(List<double> monthlyAmounts) {
    return monthlyAmounts.fold(0.0, (a, b) => a + b);
  }

  /// 미래생활비 = 현재생활비 * (1+물가)^년
  static double futureLivingCost({
    required double currentCost,
    required double inflationPercent,
    required double years,
  }) {
    final r = inflationPercent / 100;
    return currentCost * math.pow(1 + r, years);
  }

  static double roundMoney(double value, {int digits = 0}) {
    final mod = math.pow(10, digits).toDouble();
    return (value * mod).round() / mod;
  }
}
