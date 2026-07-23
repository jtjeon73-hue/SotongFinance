import '../models/enums.dart';

class LifePathStep {
  const LifePathStep({
    required this.title,
    required this.contentIds,
    required this.numbersToCheck,
    required this.actions,
    required this.mistakes,
    required this.calculatorRoutes,
    required this.officialSourceIds,
  });

  final String title;
  final List<String> contentIds;
  final List<String> numbersToCheck;
  final List<String> actions;
  final List<String> mistakes;
  final List<String> calculatorRoutes;
  final List<String> officialSourceIds;
}

class LifePath {
  const LifePath({
    required this.id,
    required this.title,
    required this.summary,
    required this.stages,
    required this.steps,
  });

  final String id;
  final String title;
  final String summary;
  final List<LifeStage> stages;
  final List<LifePathStep> steps;
}

const lifePaths = <LifePath>[
  LifePath(
    id: 'path-new-graduate',
    title: '사회초년생',
    summary: '소득·필수비·비상자금·부채부터 순서대로 봅니다.',
    stages: [LifeStage.newGraduate, LifeStage.employee],
    steps: [
      LifePathStep(
        title: '현황과 예산',
        contentIds: [
          'mm-household-status',
          'mm-monthly-budget',
          'mm-emergency-fund',
        ],
        numbersToCheck: ['세후소득', '필수비', '현금성자산'],
        actions: ['가계표 작성', '비상자금 목표', '고금리 부채 확인'],
        mistakes: ['소득 전부를 투자', '비상자금 없이 대출'],
        calculatorRoutes: [
          '/tools/cashflow',
          '/tools/savings-rate',
          '/diagnose',
        ],
        officialSourceIds: ['src-fss', 'src-fine'],
      ),
    ],
  ),
  LifePath(
    id: 'path-employee',
    title: '직장인',
    summary: '현금흐름·퇴직연금·세금 준비를 연계합니다.',
    stages: [LifeStage.employee],
    steps: [
      LifePathStep(
        title: '연간 점검',
        contentIds: [
          'mm-annual-review',
          'pension-retire-account',
          'tax-filing',
        ],
        numbersToCheck: ['순자산', '저축률', '퇴직연금 잔액'],
        actions: ['연말정산 자료', '보험 점검', '목표 우선순위'],
        mistakes: ['세제만 보고 현금 필요시기 무시'],
        calculatorRoutes: ['/tools/net-worth', '/diagnose'],
        officialSourceIds: ['src-nts', 'src-fss'],
      ),
    ],
  ),
  LifePath(
    id: 'path-family',
    title: '결혼·가족',
    summary: '공동목표·보험·부채·비상자금을 함께 봅니다.',
    stages: [LifeStage.family],
    steps: [
      LifePathStep(
        title: '가족 재무',
        contentIds: [
          'mm-couple-finance',
          'mm-insurance-review',
          'mm-debt-payoff',
        ],
        numbersToCheck: ['합산소득', '고정비', '보험료'],
        actions: ['목표합의', '보장공백 점검'],
        mistakes: ['배우자 몰래 부채'],
        calculatorRoutes: ['/diagnose', '/tools/cashflow'],
        officialSourceIds: ['src-fine'],
      ),
    ],
  ),
  LifePath(
    id: 'path-housing',
    title: '주택 준비',
    summary: '총비용·대출감당·실거주 조건을 함께 봅니다.',
    stages: [LifeStage.employee, LifeStage.family],
    steps: [
      LifePathStep(
        title: '총비용과 대출',
        contentIds: ['re-total-cost', 're-mortgage', 're-buy-rent'],
        numbersToCheck: ['자기자본', '월상환', '총취득비용'],
        actions: ['스트레스 금리', '비상자금 유지'],
        mistakes: ['한도=감당으로 착각'],
        calculatorRoutes: ['/tools/loan-payment', '/tools/acquisition-cost'],
        officialSourceIds: ['src-khfc', 'src-fss', 'src-molit'],
      ),
    ],
  ),
  LifePath(
    id: 'path-self-employed',
    title: '자영업자',
    summary: '변동소득 달력·세금·사업/생활비 분리.',
    stages: [LifeStage.selfEmployed],
    steps: [
      LifePathStep(
        title: '변동소득',
        contentIds: [
          'mm-variable-income',
          'tax-comprehensive',
          'mm-emergency-fund',
        ],
        numbersToCheck: ['최저월입금', '고정운영비', '세금월'],
        actions: ['12개월 달력', '계좌분리'],
        mistakes: ['매출=소득 혼동'],
        calculatorRoutes: ['/tools/variable-income', '/diagnose'],
        officialSourceIds: ['src-nts'],
      ),
    ],
  ),
  LifePath(
    id: 'path-farmer',
    title: '농민',
    summary: '계절현금·농지·농업대출·재해 대비.',
    stages: [LifeStage.farmer],
    steps: [
      LifePathStep(
        title: '농업 재무',
        contentIds: ['mm-variable-income', 're-farmland', 'mm-emergency-fund'],
        numbersToCheck: ['수확입금월', '농자재', '대출만기'],
        actions: ['계절달력', '농지 공식확인'],
        mistakes: ['서류만으로 개발가능 단정'],
        calculatorRoutes: ['/tools/variable-income'],
        officialSourceIds: ['src-farmland', 'src-law'],
      ),
    ],
  ),
  LifePath(
    id: 'path-midlife',
    title: '40·50대',
    summary: '부채·보험·연금·자녀·노후를 재정렬합니다.',
    stages: [LifeStage.midCareer, LifeStage.preRetirement],
    steps: [
      LifePathStep(
        title: '재정렬',
        contentIds: [
          'mm-debt-payoff',
          'pension-overview',
          'mm-insurance-review',
        ],
        numbersToCheck: ['부채', '연금4층', '보험료'],
        actions: ['우선순위 재설정', '은퇴 gap'],
        mistakes: ['자녀교육만 보고 노후 공백'],
        calculatorRoutes: ['/tools/retirement-gap', '/diagnose'],
        officialSourceIds: ['src-nps'],
      ),
    ],
  ),
  LifePath(
    id: 'path-pre-retire-10',
    title: '은퇴 10년 전',
    summary: '생활비·연금·인출·의료를 시나리오로.',
    stages: [LifeStage.preRetirement],
    steps: [
      LifePathStep(
        title: '은퇴 준비',
        contentIds: ['pension-overview', 'pension-gap', 'pension-withdrawal'],
        numbersToCheck: ['필수생활비', '연금합계', 'gap'],
        actions: ['공식 연금조회', '3시나리오'],
        mistakes: ['단일수익률 가정'],
        calculatorRoutes: ['/tools/retirement-cashflow', '/tools/pension-sum'],
        officialSourceIds: ['src-nps', 'src-nps-center'],
      ),
    ],
  ),
  LifePath(
    id: 'path-retire-soon',
    title: '은퇴 직전',
    summary: '공백기간·건강보험·인출완충.',
    stages: [LifeStage.preRetirement, LifeStage.retired],
    steps: [
      LifePathStep(
        title: '직전 점검',
        contentIds: [
          'pension-withdrawal',
          'pension-longevity',
          'mm-emergency-fund',
        ],
        numbersToCheck: ['공백월수', '현금완충', '의료대비'],
        actions: ['순서위험 학습', '지출유연화'],
        mistakes: ['안전인출률 만능화'],
        calculatorRoutes: ['/tools/sequence-risk', '/tools/future-cost'],
        officialSourceIds: ['src-nps'],
      ),
    ],
  ),
  LifePath(
    id: 'path-pensioner',
    title: '연금 수령 중',
    summary: '수령·세금·의료·배우자 구간.',
    stages: [LifeStage.retired],
    steps: [
      LifePathStep(
        title: '수령기',
        contentIds: [
          'pension-overview',
          'pension-medical',
          'pension-inheritance',
        ],
        numbersToCheck: ['월수령합', '의료비', '세금·건보'],
        actions: ['연간 노후점검'],
        mistakes: ['의료비 미반영'],
        calculatorRoutes: ['/tools/pension-sum'],
        officialSourceIds: ['src-nps', 'src-nts'],
      ),
    ],
  ),
  LifePath(
    id: 'path-couple-retire',
    title: '배우자와 함께',
    summary: '부부 합산·유족·상속 검토 질문.',
    stages: [LifeStage.family, LifeStage.retired],
    steps: [
      LifePathStep(
        title: '부부 노후',
        contentIds: [
          'pension-inheritance',
          'mm-couple-finance',
          'tax-inheritance',
        ],
        numbersToCheck: ['합산연금', '비상', '보장'],
        actions: ['유족·상속 질문목록'],
        mistakes: ['서류 미정리'],
        calculatorRoutes: ['/diagnose'],
        officialSourceIds: ['src-nps', 'src-nts'],
      ),
    ],
  ),
  LifePath(
    id: 'path-fraud',
    title: '금융피해 예방',
    summary: '경고신호·대응·공식신고.',
    stages: LifeStage.values,
    steps: [
      LifePathStep(
        title: '예방',
        contentIds: [
          'fraud-warning-signals',
          'fraud-voice-phishing',
          'fraud-investment',
          'fraud-report-fss',
        ],
        numbersToCheck: ['해당없음-신호체크'],
        actions: ['공식채널만 확인', '가족공유'],
        mistakes: ['검색광고 번호 사용'],
        calculatorRoutes: [],
        officialSourceIds: ['src-fss', 'src-fine'],
      ),
    ],
  ),
  LifePath(
    id: 'path-easy-elderly',
    title: '쉬운 금융(고령·보호자)',
    summary: '큰 글씨·사기예방·현금·보험·연금 기본만 순서대로.',
    stages: [LifeStage.retired, LifeStage.preRetirement, LifeStage.family],
    steps: [
      LifePathStep(
        title: '안전과 기본',
        contentIds: [
          'fraud-elderly',
          'fraud-warning-signals',
          'mm-emergency-fund',
          'pension-overview',
          'mm-couple-finance',
        ],
        numbersToCheck: ['현금 비상', '월 필수비', '연락처·서류'],
        actions: ['상단 큰 글씨 켜기', '공식창구만 사용', '가족·보호자와 점검'],
        mistakes: ['급한 송금', '검색광고 전화', '비밀번호 공유'],
        calculatorRoutes: ['/tools/cashflow', '/annual-review'],
        officialSourceIds: ['src-fss', 'src-nps', 'src-fine'],
      ),
    ],
  ),
];
