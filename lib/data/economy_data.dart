import '../core/utils/content_builder.dart';
import '../models/enums.dart';
import '../models/finance_content.dart';

final economyContent = <FinanceContent>[
  _ec(
    'econ-gdp',
    'GDP',
    '국내총생산 성장률은 경기 확장·위축 신호로 해석되나 개인 소득과 1:1 대응하지 않습니다.',
    ['econ-indicator-reading'],
    sourceIds: ['src-bok', 'src-kosis'],
  ),
  _ec(
    'econ-cpi',
    '물가(CPI)',
    '소비자물가는 생활비·실질소득·연금 목표에 영향. 개인 체감과 차이.',
    ['basics-inflation'],
    sourceIds: ['src-kosis'],
  ),
  _ec('econ-unemployment', '고용·실업', '고용 지표는 소득·소비 심리와 연결. 개인 직업 안정과 구분.', [
    'econ-indicator-reading',
  ]),
  _ec(
    'econ-interest-rate',
    '기준금리',
    '한국은행 기준금리는 대출·예금·채권 가격에 영향. 경로는 불확실.',
    ['bond-rate-up-price-down'],
    sourceIds: ['src-bok'],
    status: VerificationStatus.versionDependent,
  ),
  _ec(
    'econ-exchange',
    '환율',
    '원·달러 등 환율은 수입물가·해외투자·여행비에 영향.',
    ['etf-hedge'],
    sourceIds: ['src-bok'],
  ),
  _ec('econ-yield-curve', '수익률 곡선', '채권 만기별 금리 형태. 경기 기대와 연관 논의되나 단정적 예측 아님.', [
    'bond-yield-price',
  ]),
  _ec('econ-pmi', 'PMI·경기선행', '제조·서비스 PMI 등 선행 지표. 시장 기대 형성에 참고.', [
    'econ-indicator-reading',
  ]),
  _ec('econ-trade', '수출·무역', '수출입·경상수지는 환율·기업 이익·고용과 연결.', ['commodity-oil']),
  _ec(
    'econ-housing',
    '주택·건설 지표',
    '주택가격·착공·미분양 등. 지역·개인 주거와 구분.',
    ['re-location'],
    sourceIds: ['src-molit', 'src-kosis'],
  ),
  _ec(
    'econ-stock-link',
    '지표→주식',
    '경기·금리·이익 기대가 주가에 영향. 단기 방향 예측 불가.',
    ['stock-basics'],
    type: ContentType.risk,
  ),
  _ec('econ-bond-link', '지표→채권', '금리·인플레 기대가 채권 수익률·가격에 영향.', [
    'bond-rate-up-price-down',
  ]),
  _ec('econ-forex-personal', '환율과 개인 재무', '해외 ETF·유학·수입 소비·달러 자산 비중 점검.', [
    'econ-exchange',
  ]),
  _ec(
    'econ-indicator-reading',
    '지표 읽기 순서',
    '지표→시장 기대→자산 반응→내 현금흐름·부채·비상자금.',
    ['basics-decision'],
    type: ContentType.actionGuide,
  ),
  buildLesson(
    id: 'econ-no-realtime',
    title: '실시간 데이터 없음 안내',
    summary: '본 사이트는 교육용 정적 자료이며 실시간 시세·금리·환율을 제공하지 않습니다.',
    category: '경제시장',
    difficulty: Difficulty.intro,
    contentType: ContentType.officialCheck,
    keywords: ['실시간', 'ECOS', 'KOSIS'],
    relatedIds: ['econ-indicator-reading'],
    sourceIds: ['src-bok', 'src-kosis', 'src-krx'],
    reviewCycle: '상시',
    checklist: ['공식 통계 사이트 북마크', '조회 시점 기록'],
    nextActions: ['ECOS·KOSIS·KRX에서 직접 조회'],
    commonMistakes: ['교육 예시 숫자를 현재 시세로 착각', 'SNS 짤로 지표 해석'],
    sections: [
      section('목적', '데이터 출처와 한계를 명확히 합니다.'),
      section(
        '공식 출처',
        '한국은행 ECOS, 통계청 KOSIS, KRX, FSS 등에서 최신값 확인(2026-07-23 기준 안내).',
        type: ContentType.officialCheck,
      ),
      section(
        '개인 재무 연결',
        '지표 변화가 내 대출 금리·물가·연금 목표에 어떤 질문을 던지는지 정리.',
        type: ContentType.actionGuide,
      ),
      section(
        '주의',
        '가짜 실시간·조작된 차트 경계. 투자 매매 타이밍 신호가 아닙니다.',
        type: ContentType.risk,
      ),
    ],
  ),
];

FinanceContent _ec(
  String id,
  String title,
  String summary,
  List<String> related, {
  ContentType type = ContentType.concept,
  List<String> sourceIds = const ['src-bok', 'src-kosis'],
  VerificationStatus status = VerificationStatus.versionDependent,
}) => buildLesson(
  id: id,
  title: title,
  summary: summary,
  category: '경제시장',
  difficulty: Difficulty.basic,
  contentType: type,
  keywords: [title, '경제', '지표'],
  relatedIds: related,
  sourceIds: sourceIds,
  lifeStages: [LifeStage.employee, LifeStage.midCareer],
  verificationStatus: status,
  reviewCycle: '분기 1회',
  checklist: ['조회일 기록', '개인 재무 영향', '공식 출처'],
  nextActions: ['ECOS/KOSIS 해당 지표 조회'],
  commonMistakes: ['지표 하나로 매매', '과거 상관을 영구 가정'],
  sections: [
    section('목적', '$title이(가) 개인 재무 이해에 어떻게 쓰이는지 봅니다.'),
    section(
      '지표→기대→자산',
      '발표→시장 해석→주식·채권·환율 반응→내 대출·물가·연금.',
      type: ContentType.actionGuide,
    ),
    section(
      '확인',
      '공식 통계 값·개정·계절조정. 본 사이트는 실시간 미제공.',
      type: ContentType.officialCheck,
    ),
    section(
      '개인 연결',
      '비상자금, 변동금리 대출, 해외 ETF, 은퇴 생활비 물가.',
      type: ContentType.scenario,
    ),
    section('자주 하는 실수', '뉴스 헤드라인만 보고 포트폴리오 급변, 지역·개인과 거시 혼동.'),
  ],
);
