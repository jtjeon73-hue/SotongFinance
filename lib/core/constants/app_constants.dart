/// SotongFinance 전역 상수
class AppConstants {
  static const String appName = 'SotongFinance';
  static const String appTagline = '금융·자산관리 교육 플랫폼';
  static const String packageName = 'sotong_finance';
  static const String firebaseProjectId = 'sotong-finance';
  static const String hostingUrl = 'https://sotong-finance.web.app';
  static const String phase = '2단계';
  static const String referenceYear = '2026';
  static const String checkedAt = '2026-07-23';
  static const String reviewDueAt = '2026-10-23';

  static const String educationalDisclaimer =
      'SotongFinance는 금융·자산관리 학습을 위한 교육용 정보 사이트입니다. '
      '특정 금융상품, 주식, 부동산의 매수·매도 추천이나 수익 보장을 제공하지 않습니다. '
      '세금·연금·대출·보험은 개인 상황과 기준일에 따라 달라질 수 있으므로 '
      '실제 의사결정 전 공식기관과 전문가에게 확인하세요.';

  static const String calculatorDisclaimer =
      '이 계산기는 교육용 추정치를 제공합니다. 실제 계약·신고·투자 전 '
      '공식기관·금융회사·전문가 계산을 확인하세요. 입력값은 브라우저에만 '
      '머물며 서버에 저장되지 않습니다.';

  static const String noServerStorageNotice =
      '계산기·재무진단 입력값과 민감한 재무정보를 서버·쿠키·로그에 저장하지 않습니다.';

  static const String stressScenarioDisclaimer =
      '스트레스 시나리오는 가정에 따른 교육용 비교이며 미래 예측이 아닙니다.';

  static const double contentMaxWidth = 920;
  static const double sidebarWidth = 280;
  static const double desktopBreakpoint = 900;
}
