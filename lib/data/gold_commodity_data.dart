import '../core/utils/content_builder.dart';
import '../models/enums.dart';
import '../models/finance_content.dart';

final goldCommodityContent = <FinanceContent>[
  _gc(
    'gold-role',
    '금의 역할',
    '금은 저장·헤지·산업 수요 등 여러 역할이 논의되나, 수익·물가 헤지는 시기마다 다릅니다.',
    ['gold-inflation-hedge'],
  ),
  buildLesson(
    id: 'gold-inflation-hedge',
    title: '금과 인플레이션',
    summary: '금이 물가 상승을 항상 완벽히 상쇄하지는 않습니다. 기간·환율·기회비용을 함께 봅니다.',
    category: '금원자재',
    difficulty: Difficulty.basic,
    contentType: ContentType.risk,
    keywords: ['금', '인플레이션', '헤지'],
    relatedIds: ['basics-inflation', 'gold-role'],
    sourceIds: ['src-bok'],
    reviewCycle: '연 1회',
    checklist: ['보유 목적', '기간', '실질수익 가정'],
    nextActions: ['금·현금·채권 비교 시나리오 작성'],
    commonMistakes: ['금=물가 완벽 헤지', '단기 물가와 장기 금값 1:1 대응'],
    sections: [
      section('목적', '금을 인플레이션 대비 수단으로 볼 때의 한계를 이해합니다.'),
      section('확인할 숫자', '금 가격(원·달러), 환율, CPI, 보유 기간, 보관·거래 비용.'),
      section(
        '해석',
        '역사적으로 일부 기간 상관이 있었으나, 모든 기간·모든 국가에서 일관되지 않습니다. 미래도 보장되지 않습니다.',
        type: ContentType.risk,
      ),
      section(
        '실천',
        '포트폴리오 비중을 정할 때 비상자금·부채·세금·비용을 먼저 확인합니다.',
        type: ContentType.actionGuide,
      ),
      section('주의', '2026-07-23 기준 금값·물가는 변동합니다. 공식 통계를 참고하세요.'),
    ],
  ),
  _gc('gold-physical', '실물 금', '골드바·코인·주얼리 등. 보관·보험·매매 스프레드·진품 확인 비용이 있습니다.', [
    'gold-cost-compare',
  ]),
  _gc('gold-financial', '금융상품(ETF·펀드·계정)', '거래·보수·세금·추적오차·구조(실물·파생)를 확인합니다.', [
    'etf-basics',
    'gold-cost-compare',
  ]),
  buildLesson(
    id: 'gold-cost-compare',
    title: '실물 vs 금융상품 비용',
    summary: '매입·매도 스프레드, 보관, 보수, 세금을 합쳐 총비용을 비교합니다.',
    category: '금원자재',
    difficulty: Difficulty.practical,
    contentType: ContentType.calculation,
    keywords: ['비용', '스프레드', '보수'],
    relatedIds: ['gold-physical', 'gold-financial'],
    reviewCycle: '매매 전',
    checklist: ['매입가', '매도가', '보관·보수', '세금'],
    nextActions: ['동일 금액 기준 5년 보유 비용 가정표'],
    commonMistakes: ['매입가만 비교', '주얼리를 투자금으로만 계산'],
    sections: [
      section('목적', '같은 ‘금’ 노출이라도 채널별 비용 구조가 다름을 이해합니다.'),
      section(
        '실물',
        '프리미엄·공임·보관함·보험·매각 시 할인.',
        bullets: ['골드바 vs 주얼리', '매각처별 가격 차'],
      ),
      section('금융', '총보수·거래수수료·분배금 세금·괴리율.', type: ContentType.calculation),
      section(
        '실천 순서',
        '①목적·기간 ②비용 항목 나열 ③세후 시나리오 ④유동성',
        type: ContentType.actionGuide,
      ),
      section('자주 하는 실수', '단기 거래로 스프레드만 반복 지출.'),
    ],
  ),
  _gc(
    'commodity-basics',
    '원자재 기초',
    '에너지·금속·농산 등. 수요·공급·환율·지정학적 요인에 민감합니다.',
    ['commodity-risk'],
    type: ContentType.risk,
  ),
  _gc(
    'commodity-oil',
    '에너지(유가)',
    '유가는 생활비·물류·기업 원가에 영향을 줄 수 있습니다. 개인 투자는 변동성이 큽니다.',
    ['econ-trade'],
    type: ContentType.risk,
  ),
  _gc(
    'commodity-agri',
    '농산물',
    '기후·수확·정책·환율 영향. 현물·선물·ETF 구조가 다릅니다.',
    ['commodity-basics'],
    stages: [LifeStage.farmer],
  ),
  _gc(
    'commodity-risk',
    '원자재 투자 위험',
    '레버리지 ETF·선물은 손실 확대 가능. 분산도 위험 제거가 아닙니다.',
    ['basics-risk-return', 'etf-leverage-inverse'],
    type: ContentType.risk,
  ),
  _gc(
    'gold-portfolio',
    '금·원자재 비중',
    '포트폴리오 일부로 볼 때 비중·목적·재검토 주기를 정합니다. 추천 비중은 없습니다.',
    ['basics-diversification', 'basics-decision'],
  ),
];

FinanceContent _gc(
  String id,
  String title,
  String summary,
  List<String> related, {
  ContentType type = ContentType.concept,
  List<LifeStage> stages = const [LifeStage.employee, LifeStage.midCareer],
}) => buildLesson(
  id: id,
  title: title,
  summary: summary,
  category: '금원자재',
  difficulty: Difficulty.basic,
  contentType: type,
  keywords: [title, '금', '원자재'],
  relatedIds: related,
  sourceIds: ['src-bok', 'src-krx'],
  lifeStages: stages,
  reviewCycle: '반기 1회',
  checklist: ['목적', '비용', '유동성', '세금'],
  nextActions: ['보유 형태·비용 정리'],
  commonMistakes: ['안전자산만 믿고 비중 과다', '환율·비용 무시'],
  sections: [
    section('목적', '$title을(를) 이해합니다. 특정 원자재 상승을 단정하지 않습니다.'),
    section('확인할 숫자', '가격, 환율, 보관·보수, 세금, 포트폴리오 비중.'),
    section('위험', '가격 변동·유동성·구조적 위험(파생·레버리지).', type: ContentType.risk),
    section('실천 순서', '①목적 ②비용 ③비중 ④재검토', type: ContentType.actionGuide),
    section('자주 하는 실수', '인플레이션 헤지 과신, 실물·금융 비용 미비교.'),
  ],
);
