import '../core/utils/content_builder.dart';
import '../models/enums.dart';
import '../models/finance_content.dart';

final insuranceContent = <FinanceContent>[
  _ins(
    'insurance-basics',
    '보험 기초',
    '보험은 소액의 확정적 보험료로 큰 손실 위험을 전가·분산하는 계약입니다.',
    ['insurance-not-investment'],
  ),
  _ins(
    'insurance-not-investment',
    '보험≠투자상품',
    '저축·변액 연계 상품도 보장과 비용 구조를 분리해 봅니다. 수익 보장 표현을 경계합니다.',
    ['insurance-basics', 'insurance-premium'],
    type: ContentType.risk,
  ),
  _ins(
    'insurance-probability',
    '발생 확률',
    '사고·질병 발생 빈도는 통계로 추정되나 개인에게는 0 또는 1입니다.',
    ['insurance-loss-size'],
  ),
  _ins('insurance-loss-size', '손실 규모', '최악 시 필요한 자금 규모를 추정해 적정 보장 수준을 논의합니다.', [
    'insurance-retain-transfer',
  ]),
  _ins(
    'insurance-retain-transfer',
    '자기부담 vs 전가',
    '작은 손실은 자기부담, 큰·희귀 손실은 보험 전가를 검토합니다. 전부 전가는 비용 증가.',
    ['insurance-gap'],
  ),
  _ins(
    'insurance-life',
    '생명·사망 보장',
    '가족 생활비·부채 상환 등 목적별 필요액을 추정합니다. 상품 가입·해지 지시는 하지 않습니다.',
    ['insurance-gap'],
    stages: [LifeStage.family],
  ),
  _ins(
    'insurance-health',
    '질병·상해·실손',
    '실손·특약·갱신·비급여 등 구조가 복잡합니다. 약관·보장 범위를 확인합니다.',
    ['insurance-claim'],
    sourceIds: ['src-fss', 'src-fine'],
  ),
  _ins('insurance-property', '화재·재물', '주택·동산·사업장 재물 보장. 자기부담금·보장한도·면책 확인.', [
    're-checklist',
  ]),
  _ins(
    'insurance-gap',
    '보장 공백·중복',
    '없는 위험·과한 중복·낮은 한도를 점검합니다.',
    ['mm-insurance-review'],
    type: ContentType.checklist,
  ),
  _ins('insurance-premium', '보험료 부담', '월 보험료가 현금흐름·저축에 미치는 영향. 갱신 시 인상 가능.', [
    'insurance-not-investment',
  ]),
  _ins(
    'insurance-claim',
    '보험금 청구',
    '청구 서류·기간·면책·분쟁 조정 절차는 약관·금감원 안내를 따릅니다.',
    ['insurance-health'],
    status: VerificationStatus.needsReview,
  ),
  _ins(
    'insurance-review',
    '보험 정기 점검',
    '인생 이벤트(결혼·출산·대출·은퇴)마다 보장·보험료를 재점검합니다.',
    ['mm-insurance-review', 'insurance-gap'],
    type: ContentType.checklist,
  ),
];

FinanceContent _ins(
  String id,
  String title,
  String summary,
  List<String> related, {
  ContentType type = ContentType.concept,
  List<String> sourceIds = const ['src-fss', 'src-fine'],
  List<LifeStage> stages = const [LifeStage.employee, LifeStage.family],
  VerificationStatus status = VerificationStatus.educationalExample,
}) => buildLesson(
  id: id,
  title: title,
  summary: summary,
  category: '보험',
  difficulty: Difficulty.basic,
  contentType: type,
  keywords: [title, '보험', '보장'],
  relatedIds: related,
  sourceIds: sourceIds,
  lifeStages: stages,
  verificationStatus: status,
  reviewCycle: '연 1회 또는 life event',
  checklist: ['보장 목적', '보험료', '면책·자기부담', '중복·공백'],
  nextActions: ['보유 약관 목록화', 'FINE 비교는 참고만'],
  commonMistakes: ['보험=투자', '모든 위험 전가', '약관 미확인', '영업 멘트만 신뢰'],
  sections: [
    section('목적', '$title을(를) 이해해 보험을 위험 관리 도구로 봅니다. 특정 상품 가입·해지를 지시하지 않습니다.'),
    section('확인할 숫자', '월 보험료, 보장한도, 자기부담금, 갱신 주기, 필요 생활비·부채.'),
    section(
      '확률·손실',
      '발생 확률×손실 규모로 우선순위를 정합니다. 통계는 집단 기준입니다.',
      type: ContentType.risk,
    ),
    section(
      '실천 순서',
      '①위험 목록 ②자기부담 한도 ③공백·중복 ④공식·약관 확인 ⑤정기 재점검',
      type: ContentType.actionGuide,
    ),
    section('자주 하는 실수', '분류·변액 수익만 보고 보장 부족, 실손·특약 중복, 갱신 보험료 인상 미대비.'),
  ],
);
