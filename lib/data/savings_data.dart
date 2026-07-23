import '../core/utils/content_builder.dart';
import '../models/enums.dart';
import '../models/finance_content.dart';

final savingsContent = <FinanceContent>[
  _sv(
    id: 'savings-deposit-vs-installment',
    title: '예금과 적금의 차이',
    summary: '예금은 일시 예치·자유로운 입출금(상품별), 적금은 정기 납입·만기 구조가 일반적입니다.',
    related: ['savings-simple-compound', 'savings-rate-compare'],
  ),
  _sv(
    id: 'savings-simple-compound',
    title: '단리와 복리',
    summary: '예금·적금 이자 계산 방식(단리·복리·세전)을 구분해 만기 금액을 추정합니다.',
    related: ['basics-simple-compound', 'savings-tax-interest'],
    type: ContentType.calculation,
  ),
  _sv(
    id: 'savings-tax-interest',
    title: '세전·세후 이자',
    summary: '이자소득세·농특세 등으로 세후 이자가 줄어듭니다. 우대·비과세는 조건·한도가 있습니다.',
    related: ['tax-interest-dividend', 'savings-deposit-vs-installment'],
    sourceIds: ['src-nts', 'src-fss'],
    status: VerificationStatus.versionDependent,
  ),
  _sv(
    id: 'savings-early-withdrawal',
    title: '중도해지',
    summary: '만기 전 해지 시 우대금리 소멸·중도해지 수수료·세금 영향이 있을 수 있습니다.',
    related: ['savings-emergency', 'savings-maturity-ladder'],
    type: ContentType.risk,
  ),
  buildLesson(
    id: 'savings-deposit-insurance',
    title: '예금자보호',
    summary: '원금·약정 이자가 법정 한도 내에서 보호될 수 있으나, 한도·대상·예외는 개정될 수 있습니다.',
    category: '예금적금',
    difficulty: Difficulty.basic,
    contentType: ContentType.officialCheck,
    keywords: ['예금자보호', 'KDIC', '보호한도'],
    relatedIds: ['savings-deposit-vs-installment'],
    sourceIds: ['src-kdic', 'src-fss'],
    verificationStatus: VerificationStatus.versionDependent,
    reviewCycle: '예금 가입·개정 시',
    checklist: ['금융회사별 보호 대상 여부', '공동·별도 계좌 구조', '최신 한도 공식 확인'],
    nextActions: ['KDIC 보호금융상품 조회', '동일 은행 다계좌 분산 검토(교육용)'],
    commonMistakes: ['한도를 영구 불변으로 기억', '비보호 상품을 예금으로 착각'],
    sections: [
      section('목적', '예금 가입 전 보호 범위를 공식 출처로 확인하는 방법을 익힙니다.'),
      section(
        '확인할 사항',
        '보호 대상 금융회사·상품, 1인당 보호 한도, 부실 시 지급 절차. 한도 금액은 법·시행령 개정에 따라 달라질 수 있어 본 사이트에 고정 숫자를 넣지 않습니다.',
        type: ContentType.officialCheck,
      ),
      section(
        '공식 확인',
        '예금보험공사(kdic.or.kr)에서 보호금융상품·한도·FAQ를 확인하세요(2026-07-23).',
        type: ContentType.officialCheck,
      ),
      section(
        '실천 순서',
        '①상품 설명서 ②보호 대상 조회 ③분산·만기 구조 검토 ④개정 공지 구독',
        type: ContentType.actionGuide,
      ),
      section('주의', '파생·투자형 상품, 일부 펀드 등은 예금자보호와 다를 수 있습니다. 상품별로 확인하세요.'),
    ],
  ),
  _sv(
    id: 'savings-rate-compare',
    title: '금리 비교',
    summary: '연이율, 우대 조건, 세후 실질 이자, 중도해지 조건을 함께 비교합니다.',
    related: ['savings-tax-interest', 'savings-deposit-insurance'],
    sourceIds: ['src-fine', 'src-fss'],
  ),
  _sv(
    id: 'savings-emergency',
    title: '비상자금 관리',
    summary: '입출금·단기 예금 등 유동성 높은 형태로 비상자금을 분리 보관합니다.',
    related: ['mm-emergency-fund', 'savings-early-withdrawal'],
  ),
  _sv(
    id: 'savings-maturity-ladder',
    title: '만기 분산',
    summary: '만기를 나누면 금리 재투자 시점을 분산할 수 있으나, 수익은 보장되지 않습니다.',
    related: ['savings-early-withdrawal', 'basics-liquidity'],
  ),
  _sv(
    id: 'savings-goals',
    title: '저축 목표',
    summary: '기간·금액·우선순위가 있는 저축 목표를 세우고 진행률을 추적합니다.',
    related: ['mm-financial-goals', 'savings-deposit-vs-installment'],
  ),
];

FinanceContent _sv({
  required String id,
  required String title,
  required String summary,
  List<String> related = const [],
  List<String> sourceIds = const ['src-fss', 'src-kdic'],
  ContentType type = ContentType.concept,
  VerificationStatus status = VerificationStatus.educationalExample,
}) => buildLesson(
  id: id,
  title: title,
  summary: summary,
  category: '예금적금',
  difficulty: Difficulty.basic,
  contentType: type,
  keywords: [title, '예금', '적금'],
  relatedIds: related,
  sourceIds: sourceIds,
  lifeStages: [LifeStage.newGraduate, LifeStage.employee, LifeStage.family],
  verificationStatus: status,
  reviewCycle: '분기 1회 또는 금리 변동 시',
  checklist: ['세전·세후 금리', '우대 조건 충족', '중도해지 패널티', '예금자보호 대상'],
  nextActions: ['보유 예금·적금 조건 정리', 'FINE·금융사 약관 재확인'],
  commonMistakes: ['최고 금리만 보고 조건 무시', 'CMA·MMDA를 무조건 예금으로 가정'],
  sections: [
    section(
      '목적',
      '$title 개념을 이해하고 본인 예금·적금 조건과 대조합니다. 2026년 금리·세율은 변동할 수 있습니다.',
    ),
    section('확인할 숫자', '약정 금리, 우대·가산, 세후 이자, 만기, 중도해지 손실, 최소 잔액·납입일.'),
    section(
      '계산·비교',
      '만기 수령액=원금+이자(세전)−세금. 복리·단리, 납입 주기에 따라 달라집니다. 사이트 계산기는 교육용입니다.',
      type: ContentType.calculation,
    ),
    section(
      '실천 순서',
      '①목적·기간 ②상품 후보 ③세후·조건 비교 ④가입 ⑤만기·재투자 점검',
      type: ContentType.actionGuide,
    ),
    section('자주 하는 실수', '금리 인상기에 장기 고정만 선택, 비상자금까지 장기 묶음, 보호·세금 미확인.'),
  ],
);
