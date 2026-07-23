import '../core/utils/content_builder.dart';
import '../models/enums.dart';
import '../models/finance_content.dart';

final moneyManagementContent = <FinanceContent>[
  _mm(
    id: 'mm-household-status',
    title: '가계 재무현황',
    summary: '가계의 자산·부채·현금흐름·보험·연금을 한눈에 정리하는 출발점입니다.',
    related: ['basics-net-worth', 'mm-annual-review'],
    stages: [LifeStage.employee, LifeStage.family],
  ),
  _mm(
    id: 'mm-monthly-budget',
    title: '월 예산',
    summary: '세후 소득 안에서 지출 상한을 정하고, 저축·투자·상환을 먼저 배치합니다.',
    related: ['basics-income-expense', 'mm-fixed-variable'],
    stages: [LifeStage.newGraduate, LifeStage.employee],
  ),
  _mm(
    id: 'mm-fixed-variable',
    title: '고정비·변동비',
    summary: '고정비는 줄이기 어렵고, 변동비는 습관·선택에 따라 조정 여지가 큽니다.',
    related: ['mm-monthly-budget', 'mm-variable-income'],
    stages: [LifeStage.employee, LifeStage.family],
  ),
  _mm(
    id: 'mm-emergency-fund',
    title: '비상자금',
    summary: '소득 중단·큰 지출에 대비하는 현금성 자금. 규모는 가족·부채·직업에 따라 다릅니다.',
    related: ['basics-liquidity', 'savings-emergency'],
    stages: [LifeStage.employee, LifeStage.selfEmployed, LifeStage.farmer],
  ),
  _mm(
    id: 'mm-debt-payoff',
    title: '부채 상환',
    summary: '이자율·만기·유동성을 기준으로 상환 순서와 여력을 점검합니다.',
    related: ['loan-repayment-methods', 'basics-assets-liabilities'],
    stages: [LifeStage.employee, LifeStage.family],
  ),
  _mm(
    id: 'mm-financial-goals',
    title: '재무목표',
    summary: '기간·금액·우선순위가 있는 목표를 세우고, 시나리오별로 추적합니다.',
    related: ['mm-monthly-budget', 'savings-goals'],
    stages: [LifeStage.newGraduate, LifeStage.midCareer],
  ),
  _mm(
    id: 'mm-insurance-review',
    title: '보험 점검',
    summary: '보장 공백·중복·보험료 부담을 점검합니다. 보험은 투자상품이 아닙니다.',
    related: ['insurance-basics', 'insurance-gap'],
    stages: [LifeStage.family, LifeStage.midCareer],
    sourceIds: ['src-fss', 'src-fine'],
  ),
  _mm(
    id: 'mm-investable-amount',
    title: '투자 가능금액',
    summary: '비상자금·부채·단기 목표를 제외한 뒤 남는 금액만 투자 후보로 봅니다.',
    related: ['basics-risk-return', 'mm-emergency-fund'],
    stages: [LifeStage.employee, LifeStage.midCareer],
  ),
  _mm(
    id: 'mm-annual-review',
    title: '연간 재무점검',
    summary: '1년 단위로 순자산·현금흐름·목표·세금·연금을 종합 점검합니다.',
    related: ['mm-household-status', 'tax-year-end'],
    stages: [LifeStage.employee, LifeStage.preRetirement],
    reviewCycle: '연 1회',
  ),
  _mm(
    id: 'mm-couple-finance',
    title: '부부 돈 관리',
    summary: '공동·개인 계좌, 목표, 지출 기준을 합의하고 기록 방식을 맞춥니다.',
    related: ['mm-monthly-budget', 'mm-financial-goals'],
    stages: [LifeStage.family],
  ),
  _mm(
    id: 'mm-variable-income',
    title: '자영업자·농민의 변동소득',
    summary: '들쭉날쭉한 소득은 평균·최저·계절성을 함께 보고 예산·비상자금을 넓게 잡습니다.',
    related: ['basics-cashflow', 'mm-emergency-fund'],
    stages: [LifeStage.selfEmployed, LifeStage.farmer],
    extraSections: [
      section(
        '계절성 현금흐름',
        '농민은 파종·수확·유통 시기에 지출·수입이 몰릴 수 있습니다. 자영업은 성수기·비수기 매출 차이를 12~24개월 표로 만듭니다.',
        bullets: [
          '성수기 잉여를 비수기·세금·설비에 배분',
          '최저 3개월 필수지출을 별도 적립',
          '정부·공식 통계로 업종 계절 참고',
        ],
      ),
    ],
  ),
  _mm(
    id: 'mm-records-docs',
    title: '금융기록과 문서관리',
    summary: '계약서·세금·보험·대출 서류를 체계적으로 보관하면 분쟁·신고 시 도움이 됩니다.',
    related: ['mm-annual-review', 'fraud-records'],
    stages: [LifeStage.employee, LifeStage.selfEmployed],
  ),
];

FinanceContent _mm({
  required String id,
  required String title,
  required String summary,
  List<String> related = const [],
  List<LifeStage> stages = const [LifeStage.employee],
  List<String> sourceIds = const ['src-kosis'],
  String reviewCycle = '월 1회',
  List<ContentSection> extraSections = const [],
}) => buildLesson(
  id: id,
  title: title,
  summary: summary,
  category: '돈관리',
  difficulty: Difficulty.basic,
  contentType: ContentType.actionGuide,
  keywords: [title.split('·').first, '가계', '재무'],
  relatedIds: related,
  sourceIds: sourceIds,
  lifeStages: stages,
  reviewCycle: reviewCycle,
  checklist: ['목적 명확화', '관련 숫자 최신화', '공식·전문가 확인 필요 항목 표시'],
  nextActions: ['이번 달 장부·통장 정리', '다음 점검일 캘린더 등록'],
  commonMistakes: ['감으로만 관리', '한 번 정리 후 방치', '타인 사례를 그대로 적용'],
  sections: [
    section(
      '목적',
      '$title을(를) 통해 가계 재무의 한 축을 점검합니다. 개인·가족 상황마다 적정 수치는 다르며, 본 내용은 2026-07-23 기준 교육용입니다.',
    ),
    section(
      '확인할 숫자',
      '세후 소득, 필수·선택 지출, 저축·투자·상환액, 부채 잔액·이자, 비상자금 개월수, 보험료, 세금·4대보험을 해당 주제에 맞게 추립니다.',
    ),
    section(
      '계산·이해 방법',
      '비율(저축률·부채비율), 잔액(순자산), 기간(목표까지 개월) 중 주제에 맞는 지표를 선택합니다. 계산기는 교육용이며 신고·약정 금액을 대체하지 않습니다.',
      type: ContentType.calculation,
    ),
    section(
      '실천 순서',
      '①현황 수집 ②분류·계산 ③목표와 비교 ④조정안 1~2개 ⑤${reviewCycle == '연 1회' ? '연간' : '다음 점검일'} 재검토',
      type: ContentType.actionGuide,
    ),
    section(
      '자주 하는 실수',
      '세전 소득·카드 한도 혼동, 비상자금 없이 투자 확대, 부부·사업·개인 계좌 미분리, 공식 규정 변경 미반영.',
    ),
    ...extraSections,
    if (extraSections.isEmpty)
      section(
        '점검 주기',
        '권장 주기: $reviewCycle. 세법·금리·고용 변화 시에는 즉시 공식 출처를 확인하세요.',
        type: ContentType.checklist,
      ),
  ],
);
