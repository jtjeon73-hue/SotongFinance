import '../core/utils/content_builder.dart';
import '../models/enums.dart';
import '../models/finance_content.dart';

final stockEtfContent = <FinanceContent>[
  _st(
    'stock-basics',
    '주식 기초',
    '주식은 기업의 소유 지분 일부로, 가격은 수요·공급·실적·시장 심리 등에 영향을 받습니다.',
    ['stock-market-structure'],
  ),
  _st(
    'stock-market-structure',
    '주식시장 구조',
    '유가증권시장·코스닥, 호가·체결, 공시(KRX·DART) 체계를 이해합니다.',
    ['stock-basics'],
    sourceIds: ['src-krx'],
  ),
  _st(
    'stock-per',
    'PER(주가수익비율)',
    'PER=주가÷주당순이익. 업종·성장·일회성 손익에 따라 해석이 달라지며 단독 판단 지표가 아닙니다.',
    ['stock-pbr', 'stock-portfolio-risk'],
  ),
  _st(
    'stock-pbr',
    'PBR(주가순자산비율)',
    'PBR=주가÷주당순자산. 자산 품질·수익성과 함께 봐야 하며 저PBR=저평가를 의미하지 않습니다.',
    ['stock-per'],
  ),
  _st(
    'stock-dividend',
    '배당',
    '배당은 이익 배분이며, 배당수익률·성향·세금·지속 가능성을 함께 봅니다. 배당 약속은 변경될 수 있습니다.',
    ['tax-interest-dividend'],
  ),
  _st(
    'etf-basics',
    'ETF 기초',
    'ETF는 기초지수·자산을 추종하는 상장펀드로, 장중 매매·분배금·보수가 있습니다.',
    ['etf-index'],
    sourceIds: ['src-krx'],
  ),
  _st(
    'etf-index',
    '기초지수',
    'ETF가 추종하는 지수·규칙을 확인합니다. 동일 이름 ETF도 지수·비중이 다를 수 있습니다.',
    ['etf-basics'],
  ),
  _st(
    'etf-expense',
    '총보수',
    '운용·판매보수 등 총보수(TER)는 장기 수익에 영향을 줄 수 있습니다. 상품별로 비교합니다.',
    ['etf-basics'],
  ),
  _st(
    'etf-tracking-error',
    '추적오차',
    '지수 대비 ETF 수익률 차이. 복제 방식·비용·분배·환헤지가 원인일 수 있습니다.',
    ['etf-index', 'etf-synthetic-physical'],
  ),
  _st(
    'etf-premium-discount',
    '괴리율',
    'ETF 시장가와 순자산가치(NAV) 차이. 일시적 괴리는 수렴할 수 있으나 보장되지 않습니다.',
    ['etf-volume'],
  ),
  _st('etf-volume', '거래량', '유동성·스프레드·체결 가격에 영향. 거래량만으로 투자 가치를 판단하지 않습니다.', [
    'etf-premium-discount',
  ]),
  _st('etf-distribution', '분배금', '보유자에게 지급되는 분배. 재투자·세금·총보수와 함께 실질 수익을 봅니다.', [
    'stock-dividend',
  ]),
  _st('etf-hedge', '환헤지', '해외 자산 ETF의 환율 노출을 헤지하는 방식. 환율 상승·하락 시 성과 차이가 납니다.', [
    'econ-exchange',
  ]),
  _st(
    'etf-synthetic-physical',
    '합성·실물',
    '실물은 자산 보유, 합성은 파생 등으로 추종. 상대방·구조·보수·위험이 다릅니다.',
    ['etf-tracking-error'],
    type: ContentType.risk,
  ),
  _st(
    'etf-leverage-inverse',
    '레버리지·인버스',
    '일일 목표 수익률 배수·반대 방향. 장기 보유 시 목표와 괴리(변동성 드래그)가 클 수 있습니다.',
    ['basics-risk-return'],
    type: ContentType.risk,
  ),
  _st(
    'etf-delisting',
    '상장폐지',
    'ETF 상장폐지 시 환매·청산 절차·세금·대체 상품 검토가 필요합니다. 절차는 시점·사유별로 다릅니다.',
    ['etf-basics'],
    status: VerificationStatus.needsReview,
  ),
  _st(
    'stock-portfolio-risk',
    '주식·ETF 포트폴리오 위험',
    '분산·비중·리밸런싱·비용·세금을 점검합니다. 특정 종목·섹터 추천이 아닙니다.',
    ['basics-diversification', 'basics-decision'],
    type: ContentType.risk,
  ),
];

FinanceContent _st(
  String id,
  String title,
  String summary,
  List<String> related, {
  ContentType type = ContentType.concept,
  List<String> sourceIds = const ['src-krx', 'src-fss'],
  VerificationStatus status = VerificationStatus.educationalExample,
}) => buildLesson(
  id: id,
  title: title,
  summary: summary,
  category: '주식ETF',
  difficulty: Difficulty.basic,
  contentType: type,
  keywords: [title, '주식', 'ETF'],
  relatedIds: related,
  sourceIds: sourceIds,
  lifeStages: [LifeStage.employee, LifeStage.midCareer],
  verificationStatus: status,
  reviewCycle: '분기 1회',
  checklist: ['투자 목적·기간', '비상자금 분리', '보수·세금', '공시 확인'],
  nextActions: ['보유 종목·ETF 설명서 읽기', '16단계 의사결정 적용'],
  commonMistakes: [
    'PER·PBR만 보고 매매',
    '과거 수익률=미래',
    '레버리지·인버스 장기 보유',
    '특정 종목 추천 맹신',
  ],
  sections: [
    section('목적', '$title을(를) 이해해 주식·ETF 관련 정보를 읽는 능력을 기릅니다. 매수·매도 신호가 아닙니다.'),
    section('확인할 숫자', '가격·PER·PBR·배당수익률·총보수·추적오차·괴리율·거래량·분배금·환율(해외).'),
    section(
      '해석 주의',
      '재무지표는 회계 정책·일회성 항목·업종 특성에 영향을 받습니다. 단일 지표로 저평가·고평가를 단정하지 마세요.',
      type: ContentType.risk,
    ),
    section(
      '실천 순서',
      '①교육·공시 ②본인 목표 ③비상자금·부채 ④비중·분산 ⑤기록·재검토',
      type: ContentType.actionGuide,
    ),
    section('자주 하는 실수', '뉴스·커뮤니티만 의존, ETF 이름만 보고 지수 미확인, 상장폐지·합성 구조 무시.'),
  ],
);
