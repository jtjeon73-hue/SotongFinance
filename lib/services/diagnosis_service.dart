import '../core/utils/finance_math.dart';

/// 로컬 전용 교육용 재무진단 (서버 저장 없음)
class DiagnosisInput {
  const DiagnosisInput({
    required this.monthlyIncome,
    required this.monthlyEssential,
    required this.monthlyTotalExpense,
    required this.cashLike,
    required this.totalAssets,
    required this.totalLiabilities,
    required this.monthlyDebtPayment,
    required this.monthlyPensionSum,
    required this.yearsToRetire,
  });

  final double monthlyIncome;
  final double monthlyEssential;
  final double monthlyTotalExpense;
  final double cashLike;
  final double totalAssets;
  final double totalLiabilities;
  final double monthlyDebtPayment;
  final double monthlyPensionSum;
  final double yearsToRetire;
}

class DiagnosisResult {
  const DiagnosisResult({
    required this.cashFlow,
    required this.savingsRate,
    required this.netWorth,
    required this.debtRatio,
    required this.emergencyMonths,
    required this.paymentBurden,
    required this.notes,
    required this.copyText,
  });

  final double cashFlow;
  final double? savingsRate;
  final double netWorth;
  final double? debtRatio;
  final double? emergencyMonths;
  final double? paymentBurden;
  final List<String> notes;
  final String copyText;
}

DiagnosisResult runDiagnosis(DiagnosisInput i) {
  final notes = <String>[
    '교육용 추정치입니다. 좋음/나쁨을 단정하지 않습니다.',
    '입력값은 브라우저 메모리에만 있으며 서버에 저장되지 않습니다.',
    '세금·연금·규제는 공식기관·전문가 확인이 필요할 수 있습니다.',
  ];

  final cashFlow = FinanceMath.monthlyCashFlow(
    income: i.monthlyIncome,
    expenses: i.monthlyTotalExpense,
  );
  double? savingsRate;
  try {
    final savings = i.monthlyIncome - i.monthlyTotalExpense;
    savingsRate = FinanceMath.savingsRate(
      income: i.monthlyIncome,
      savings: savings > 0 ? savings : 0,
    );
  } catch (_) {
    notes.add('저축률: 소득이 0이면 계산하지 않습니다.');
  }

  final netWorth = FinanceMath.netWorth(
    assets: i.totalAssets,
    liabilities: i.totalLiabilities,
  );

  double? debtRatio;
  try {
    debtRatio = FinanceMath.debtRatioPercent(
      liabilities: i.totalLiabilities,
      assets: i.totalAssets,
    );
  } catch (_) {
    notes.add('부채비중: 자산이 0이면 계산하지 않습니다.');
  }

  double? emergencyMonths;
  try {
    emergencyMonths = FinanceMath.emergencyMonths(
      cashLike: i.cashLike,
      monthlyEssential: i.monthlyEssential,
    );
  } catch (_) {
    notes.add('비상자금 개월: 필수지출을 확인해 주세요.');
  }

  double? burden;
  try {
    burden = FinanceMath.paymentBurdenPercent(
      monthlyPayment: i.monthlyDebtPayment,
      monthlyIncome: i.monthlyIncome,
    );
  } catch (_) {
    notes.add('상환부담: 소득이 0이면 계산하지 않습니다.');
  }

  if (i.yearsToRetire > 0 && i.monthlyPensionSum > 0) {
    notes.add(
      '은퇴까지 ${i.yearsToRetire.round()}년·연금월합 입력 기준으로, '
      '생활비·의료·공백기간을 시나리오로 추가 확인하세요.',
    );
  } else {
    notes.add('은퇴 준비: 국민연금 공식 조회와 생활비 시나리오를 권장합니다.');
  }

  if (cashFlow < 0) {
    notes.add('월 현금흐름이 음수입니다. 필수비·부채·소득을 재점검하세요.');
  }
  if (emergencyMonths != null && emergencyMonths < 1) {
    notes.add('현금성 완충이 필수지출 대비 짧을 수 있습니다. 직업·부양에 따라 다릅니다.');
  }

  final copy = StringBuffer()
    ..writeln('SotongFinance 교육용 재무진단 (비저장)')
    ..writeln('월현금흐름: ${cashFlow.round()}원')
    ..writeln('저축률: ${savingsRate?.toStringAsFixed(1) ?? "-"}%')
    ..writeln('순자산: ${netWorth.round()}원')
    ..writeln('부채비중: ${debtRatio?.toStringAsFixed(1) ?? "-"}%')
    ..writeln('비상자금개월: ${emergencyMonths?.toStringAsFixed(1) ?? "-"}')
    ..writeln('상환부담: ${burden?.toStringAsFixed(1) ?? "-"}%')
    ..writeln(notes.map((e) => '- $e').join('\n'));

  return DiagnosisResult(
    cashFlow: cashFlow,
    savingsRate: savingsRate,
    netWorth: netWorth,
    debtRatio: debtRatio,
    emergencyMonths: emergencyMonths,
    paymentBurden: burden,
    notes: notes,
    copyText: copy.toString(),
  );
}
