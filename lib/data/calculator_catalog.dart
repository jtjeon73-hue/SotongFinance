import '../core/utils/finance_math.dart';
import '../models/calculator_definition.dart';

const calculatorCatalog = <CalculatorDefinition>[
  CalculatorDefinition(
    id: 'calc-net-worth',
    title: '순자산',
    purpose: '자산에서 부채를 뺀 순자산을 교육용으로 계산합니다.',
    formula: '순자산 = 총자산 − 총부채',
    fields: [
      CalculatorField(key: 'assets', label: '총자산', unit: '원'),
      CalculatorField(key: 'liabilities', label: '총부채', unit: '원'),
    ],
    limitations: ['시가·장부가 혼동 주의', '숨은 부채를 빠뜨리면 과대평가'],
    example: '자산 1억, 부채 3,000만 → 순자산 7,000만',
    route: '/tools/net-worth',
  ),
  CalculatorDefinition(
    id: 'calc-cashflow',
    title: '월 현금흐름',
    purpose: '한 달 소득과 지출의 차이를 확인합니다.',
    formula: '월 현금흐름 = 월소득 − 월지출',
    fields: [
      CalculatorField(key: 'income', label: '월소득', unit: '원'),
      CalculatorField(key: 'expenses', label: '월지출', unit: '원'),
    ],
    limitations: ['변동소득은 평균과 계절을 함께 보세요'],
    example: '소득 300만, 지출 250만 → +50만',
    route: '/tools/cashflow',
  ),
  CalculatorDefinition(
    id: 'calc-savings-rate',
    title: '저축률',
    purpose: '소득 대비 저축·투자의 비율을 봅니다.',
    formula: '저축률(%) = 저축액 ÷ 소득 × 100',
    fields: [
      CalculatorField(key: 'income', label: '월소득', unit: '원'),
      CalculatorField(key: 'savings', label: '월저축·투자', unit: '원'),
    ],
    limitations: ['강제저축과 임의저축을 구분해 기록하세요'],
    example: '소득 400만, 저축 80만 → 20%',
    route: '/tools/savings-rate',
  ),
  CalculatorDefinition(
    id: 'calc-simple',
    title: '단리',
    purpose: '원금에만 이자가 붙는 단리 원금+이자를 계산합니다.',
    formula: '만기금액 = 원금 × (1 + 연이율 × 기간)',
    fields: [
      CalculatorField(key: 'principal', label: '원금', unit: '원'),
      CalculatorField(key: 'rate', label: '연이율', unit: '%'),
      CalculatorField(key: 'years', label: '기간', unit: '년'),
    ],
    limitations: ['세금·우대조건은 반영하지 않습니다'],
    example: '1,000만, 3%, 2년',
    route: '/tools/simple-interest',
  ),
  CalculatorDefinition(
    id: 'calc-compound',
    title: '복리',
    purpose: '이자에 이자가 붙는 복리 만기금액을 계산합니다.',
    formula: 'A = P × (1 + r/n)^(n×t)',
    fields: [
      CalculatorField(key: 'principal', label: '원금', unit: '원'),
      CalculatorField(key: 'rate', label: '연이율', unit: '%'),
      CalculatorField(key: 'years', label: '기간', unit: '년'),
      CalculatorField(
        key: 'n',
        label: '연간 복리횟수',
        unit: '회',
        defaultValue: '1',
        hint: '1=연1회, 12=월복리',
      ),
    ],
    limitations: ['과거 수익률이 미래를 보장하지 않습니다', '세금 미반영'],
    example: '1,000만, 5%, 10년, 연1회',
    route: '/tools/compound-interest',
  ),
  CalculatorDefinition(
    id: 'calc-real-return',
    title: '실질수익률',
    purpose: '물가를 반영한 실질 수익률을 교육용으로 추정합니다.',
    formula: '실질 ≈ (1+명목)/(1+물가) − 1',
    fields: [
      CalculatorField(key: 'nominal', label: '명목수익률', unit: '%'),
      CalculatorField(key: 'inflation', label: '물가상승률', unit: '%'),
    ],
    limitations: ['물가 가정에 따라 결과가 달라집니다'],
    example: '명목 5%, 물가 2%',
    route: '/tools/real-return',
  ),
  CalculatorDefinition(
    id: 'calc-loan-payment',
    title: '대출 월상환액(원리금균등)',
    purpose: '원리금균등 방식의 월상환액을 추정합니다.',
    formula: 'M = P × r(1+r)^n / ((1+r)^n − 1)',
    fields: [
      CalculatorField(key: 'principal', label: '대출원금', unit: '원'),
      CalculatorField(key: 'rate', label: '연이율', unit: '%'),
      CalculatorField(key: 'months', label: '기간', unit: '개월'),
    ],
    limitations: ['중도상환수수료·보험료 미반영', '실제 약정과 다를 수 있음'],
    example: '1억, 4%, 360개월',
    route: '/tools/loan-payment',
  ),
  CalculatorDefinition(
    id: 'calc-equal-payment',
    title: '원리금균등 상환',
    purpose: '월상환액과 총이자를 함께 봅니다.',
    formula: '총이자 = 월상환액 × 개월 − 원금',
    fields: [
      CalculatorField(key: 'principal', label: '대출원금', unit: '원'),
      CalculatorField(key: 'rate', label: '연이율', unit: '%'),
      CalculatorField(key: 'months', label: '기간', unit: '개월'),
    ],
    limitations: ['교육용 추정'],
    example: '5,000만, 5%, 60개월',
    route: '/tools/equal-payment',
  ),
  CalculatorDefinition(
    id: 'calc-equal-principal',
    title: '원금균등 비교',
    purpose: '원금균등 첫 달 상환액과 총이자를 원리금균등과 비교합니다.',
    formula: '원금균등 총이자 ≈ 원금 × 월이율 × (n+1)/2',
    fields: [
      CalculatorField(key: 'principal', label: '대출원금', unit: '원'),
      CalculatorField(key: 'rate', label: '연이율', unit: '%'),
      CalculatorField(key: 'months', label: '기간', unit: '개월'),
    ],
    limitations: ['실제 상품 조건은 금융회사 확인'],
    example: '5,000만, 5%, 60개월',
    route: '/tools/equal-principal',
  ),
  CalculatorDefinition(
    id: 'calc-invest-return',
    title: '투자 손익률',
    purpose: '매수·매도 금액 기준 손익률을 계산합니다.',
    formula: '손익률(%) = (매도 − 매수) ÷ 매수 × 100',
    fields: [
      CalculatorField(key: 'buy', label: '매수금액', unit: '원'),
      CalculatorField(key: 'sell', label: '매도금액', unit: '원'),
    ],
    limitations: ['수수료·세금·환율 미반영', '과거 결과가 미래를 보장하지 않음'],
    example: '매수 100만, 매도 110만 → +10%',
    route: '/tools/invest-return',
  ),
  CalculatorDefinition(
    id: 'calc-rental-yield',
    title: '임대수익률 기초',
    purpose: '연임대소득 ÷ 매입가의 단순 수익률을 봅니다.',
    formula: '임대수익률(%) = 연임대소득 ÷ 매입가 × 100',
    fields: [
      CalculatorField(key: 'rent', label: '연임대소득', unit: '원'),
      CalculatorField(key: 'price', label: '매입가', unit: '원'),
    ],
    limitations: ['공실·수선·세금·이자 미반영', '가격 상승을 단정하지 마세요'],
    example: '연임대 600만, 매입 2억 → 3%',
    route: '/tools/rental-yield',
  ),
  CalculatorDefinition(
    id: 'calc-retirement-gap',
    title: '은퇴자금 부족액 기초',
    purpose: '필요 총액과 예상 자산의 차이를 봅니다.',
    formula: '부족액 = 필요총액 − 예상자산',
    fields: [
      CalculatorField(key: 'needed', label: '필요 총액', unit: '원'),
      CalculatorField(key: 'expected', label: '예상 자산', unit: '원'),
    ],
    limitations: ['수명·수익률을 하나로 확정하지 말고 시나리오 비교'],
    example: '필요 5억, 예상 3.5억 → 부족 1.5억',
    route: '/tools/retirement-gap',
  ),
  CalculatorDefinition(
    id: 'calc-pension-sum',
    title: '연금 월수령 합계',
    purpose: '여러 연금의 월수령액을 합산합니다.',
    formula: '합계 = 국민 + 퇴직 + 개인 + 기타',
    fields: [
      CalculatorField(key: 'nps', label: '국민연금(월)', unit: '원'),
      CalculatorField(key: 'retire', label: '퇴직연금(월)', unit: '원'),
      CalculatorField(key: 'personal', label: '개인연금(월)', unit: '원'),
      CalculatorField(
        key: 'other',
        label: '기타(월)',
        unit: '원',
        defaultValue: '0',
      ),
    ],
    limitations: ['국민연금은 공단 공식 조회를 우선하세요', '세금·건보료 미반영'],
    example: '각 항목을 원 단위로 입력',
    route: '/tools/pension-sum',
  ),
  CalculatorDefinition(
    id: 'calc-future-cost',
    title: '물가상승 미래생활비',
    purpose: '물가 가정에 따른 미래 생활비를 추정합니다.',
    formula: '미래생활비 = 현재 × (1+물가)^년',
    fields: [
      CalculatorField(key: 'current', label: '현재 월생활비', unit: '원'),
      CalculatorField(key: 'inflation', label: '연 물가상승률', unit: '%'),
      CalculatorField(key: 'years', label: '기간', unit: '년'),
    ],
    limitations: ['물가 가정은 시나리오별로 비교하세요'],
    example: '월 200만, 2%, 20년',
    route: '/tools/future-cost',
  ),
  CalculatorDefinition(
    id: 'calc-debt-burden',
    title: '대출상환 부담',
    purpose: '월소득 대비 상환액 비중을 교육용으로 봅니다.',
    formula: '부담(%) = 월상환 ÷ 월소득 × 100',
    fields: [
      CalculatorField(key: 'payment', label: '월 상환합계', unit: '원'),
      CalculatorField(key: 'income', label: '월소득', unit: '원'),
    ],
    limitations: ['DSR 공식 계산을 대체하지 않음'],
    route: '/tools/debt-burden',
  ),
  CalculatorDefinition(
    id: 'calc-emergency-months',
    title: '비상자금 충당개월',
    purpose: '현금성자산이 월 필수지출을 몇 개월 감당하는지 봅니다.',
    formula: '개월 = 현금성 ÷ 월필수지출',
    fields: [
      CalculatorField(key: 'cash', label: '현금성자산', unit: '원'),
      CalculatorField(key: 'essential', label: '월 필수지출', unit: '원'),
    ],
    limitations: ['직업·부양에 따라 목표 개월이 다름', '무조건 N개월 단정 금지'],
    route: '/tools/emergency-months',
  ),
  CalculatorDefinition(
    id: 'calc-net-rent',
    title: '순임대현금흐름',
    purpose: '연임대에서 연비용을 뺀 순현금흐름(교육용).',
    formula: '순임대 = 연임대 − 연비용',
    fields: [
      CalculatorField(key: 'rent', label: '연임대소득', unit: '원'),
      CalculatorField(key: 'costs', label: '연비용(공실·수선·세금·이자 등)', unit: '원'),
    ],
    limitations: ['가격상승 가정 없음', '세후 확정 아님'],
    route: '/tools/net-rent',
  ),
  CalculatorDefinition(
    id: 'calc-acquisition-cost',
    title: '부동산 총취득비용 합계',
    purpose: '매매가와 부대비용을 합산합니다(세율 미내장).',
    formula: '합계 = 매매가 + 세금추정 + 중개 + 법무 + 수리 + 기타',
    fields: [
      CalculatorField(key: 'price', label: '매매가', unit: '원'),
      CalculatorField(key: 'tax', label: '취득관련세금(본인추정)', unit: '원'),
      CalculatorField(key: 'broker', label: '중개보수', unit: '원'),
      CalculatorField(key: 'legal', label: '법무·등기', unit: '원'),
      CalculatorField(key: 'repair', label: '즉시수리', unit: '원'),
      CalculatorField(key: 'other', label: '기타', unit: '원', defaultValue: '0'),
    ],
    limitations: ['세율·중개요율은 공식·약정 확인', '교육용 합계'],
    route: '/tools/acquisition-cost',
  ),
  CalculatorDefinition(
    id: 'calc-etf-fee',
    title: 'ETF 비용 장기영향',
    purpose: '총보수를 단순 차감한 교육용 미래가치.',
    formula: '최종 ≈ 원금 × (1 + 총수익% − 보수%)^년',
    fields: [
      CalculatorField(key: 'principal', label: '원금', unit: '원'),
      CalculatorField(key: 'gross', label: '가정 총수익률', unit: '%'),
      CalculatorField(key: 'fee', label: '연 총보수', unit: '%'),
      CalculatorField(key: 'years', label: '기간', unit: '년'),
    ],
    limitations: ['과거≠미래', '추적오차·세금 미반영'],
    route: '/tools/etf-fee',
  ),
  CalculatorDefinition(
    id: 'calc-recovery',
    title: '투자손실 회복률',
    purpose: '손실 후 원금 회복에 필요한 수익률(교육).',
    formula: '회복률 = 손실% / (1 − 손실%) × 100',
    fields: [
      CalculatorField(
        key: 'loss',
        label: '손실률',
        unit: '%',
        hint: '예: 20이면 20% 하락',
      ),
    ],
    limitations: ['실제 투자 권유 아님'],
    route: '/tools/recovery',
  ),
  CalculatorDefinition(
    id: 'calc-rate-stress',
    title: '금리상승 월상환 스트레스',
    purpose: '금리가 올랐을 때 원리금균등 월상환 변화를 비교합니다.',
    formula: '동일 원금·기간, 금리만 변경해 월상환 비교',
    fields: [
      CalculatorField(key: 'principal', label: '대출원금', unit: '원'),
      CalculatorField(key: 'rate', label: '현재 연이율', unit: '%'),
      CalculatorField(key: 'stress', label: '스트레스 연이율', unit: '%'),
      CalculatorField(key: 'months', label: '기간', unit: '개월'),
    ],
    limitations: ['실제 약정·수수료 미반영'],
    route: '/tools/rate-stress',
  ),
  CalculatorDefinition(
    id: 'calc-vacancy-stress',
    title: '공실·수선 스트레스',
    purpose: '공실·수선비가 늘 때 순임대현금 변화를 봅니다.',
    formula: '순임대 = 연임대 − (기본비용 + 추가공실수선)',
    fields: [
      CalculatorField(key: 'rent', label: '연임대', unit: '원'),
      CalculatorField(key: 'baseCost', label: '기본 연비용', unit: '원'),
      CalculatorField(key: 'extra', label: '추가 공실·수선', unit: '원'),
    ],
    limitations: ['가격전망 없음'],
    route: '/tools/vacancy-stress',
  ),
  CalculatorDefinition(
    id: 'calc-sequence-risk',
    title: '수익률 순서위험(교육)',
    purpose: '초반 하락 후 인출이 잔고에 미치는 단순 예시.',
    formula: '잔고1=(원금×(1+r1))−인출; 잔고2=잔고1×(1+r2)−인출',
    fields: [
      CalculatorField(key: 'principal', label: '시작원금', unit: '원'),
      CalculatorField(key: 'r1', label: '1년차 수익률', unit: '%'),
      CalculatorField(key: 'r2', label: '2년차 수익률', unit: '%'),
      CalculatorField(key: 'withdraw', label: '매년 인출', unit: '원'),
    ],
    limitations: ['2년 단순 예시', '안전인출률 단정 금지'],
    route: '/tools/sequence-risk',
  ),
  CalculatorDefinition(
    id: 'calc-variable-income',
    title: '변동소득 연간 합계',
    purpose: '분기(또는 구간) 입금 합계와 평균을 봅니다.',
    formula: '합계=q1+q2+q3+q4, 평균=합계/4',
    fields: [
      CalculatorField(key: 'q1', label: '1구간 입금', unit: '원'),
      CalculatorField(key: 'q2', label: '2구간 입금', unit: '원'),
      CalculatorField(key: 'q3', label: '3구간 입금', unit: '원'),
      CalculatorField(key: 'q4', label: '4구간 입금', unit: '원'),
    ],
    limitations: ['비용·세금 미차감', '매출≠순이익'],
    route: '/tools/variable-income',
  ),
  CalculatorDefinition(
    id: 'calc-retirement-cashflow',
    title: '은퇴기간 월갭',
    purpose: '생활비와 연금·기타소득의 월 차이를 봅니다.',
    formula: '월갭 = 생활비 − (연금합 + 기타소득)',
    fields: [
      CalculatorField(key: 'living', label: '월 생활비', unit: '원'),
      CalculatorField(key: 'pension', label: '월 연금합', unit: '원'),
      CalculatorField(
        key: 'other',
        label: '월 기타소득',
        unit: '원',
        defaultValue: '0',
      ),
    ],
    limitations: ['의료·세금·건보 별도', '국민연금은 공식조회 권장'],
    route: '/tools/retirement-cashflow',
  ),
  CalculatorDefinition(
    id: 'calc-debt-interest',
    title: '부채 총이자(원리금균등)',
    purpose: '단일 대출의 총이자를 교육용으로 계산합니다.',
    formula: '총이자 = 월상환×개월 − 원금',
    fields: [
      CalculatorField(key: 'principal', label: '원금', unit: '원'),
      CalculatorField(key: 'rate', label: '연이율', unit: '%'),
      CalculatorField(key: 'months', label: '기간', unit: '개월'),
    ],
    limitations: ['여러 대출 합산은 각각 계산 후 합산'],
    route: '/tools/debt-interest',
  ),
  CalculatorDefinition(
    id: 'calc-allocation-shift',
    title: '자산배분 변동(단순)',
    purpose: '두 자산 비중 변화에 따른 가중 가정수익(교육).',
    formula: '가중% = w1×r1 + w2×r2 (w는 %)',
    fields: [
      CalculatorField(key: 'w1', label: '자산A 비중', unit: '%'),
      CalculatorField(key: 'r1', label: '자산A 가정수익', unit: '%'),
      CalculatorField(key: 'w2', label: '자산B 비중', unit: '%'),
      CalculatorField(key: 'r2', label: '자산B 가정수익', unit: '%'),
    ],
    limitations: ['권장비율 아님', '상관·위험 미반영', '과거≠미래'],
    route: '/tools/allocation-shift',
  ),
  CalculatorDefinition(
    id: 'calc-concentration',
    title: '포트폴리오 집중도',
    purpose: '특정 자산(또는 부동산)이 총자산에서 차지하는 비중을 봅니다.',
    formula: '집중도% = 집중자산 ÷ 총자산 × 100',
    fields: [
      CalculatorField(key: 'focus', label: '집중 자산 금액', unit: '원'),
      CalculatorField(key: 'total', label: '총자산', unit: '원'),
    ],
    limitations: ['상관·유동성 미반영', '권장비중 아님'],
    route: '/tools/concentration',
  ),
  CalculatorDefinition(
    id: 'calc-drawdown',
    title: '최대낙폭(교육)',
    purpose: '고점 대비 저점 하락폭을 교육용으로 계산합니다.',
    formula: 'MDD% = (고점 − 저점) ÷ 고점 × 100',
    fields: [
      CalculatorField(key: 'peak', label: '고점', unit: '원'),
      CalculatorField(key: 'trough', label: '저점', unit: '원'),
    ],
    limitations: ['과거 지표≠미래', '하나의 위험만 설명하지 않음'],
    route: '/tools/drawdown',
  ),
  CalculatorDefinition(
    id: 'calc-rebalance',
    title: '리밸런싱 매매액',
    purpose: '목표비중으로 맞출 때 필요한 매수(+)/매도(−) 금액.',
    formula: '거래액 = 목표가 − 현재가, 목표가 = 포트폴리오×목표비중%',
    fields: [
      CalculatorField(key: 'current', label: '현재 평가액', unit: '원'),
      CalculatorField(key: 'targetW', label: '목표 비중', unit: '%'),
      CalculatorField(key: 'portfolio', label: '포트폴리오 총액', unit: '원'),
    ],
    limitations: ['세금·수수료 미반영', '수익률 극대화 목적 아님'],
    route: '/tools/rebalance',
  ),
  CalculatorDefinition(
    id: 'calc-withdrawal',
    title: '은퇴 인출 시나리오(1년)',
    purpose: '가정 수익 후 정액 인출 잔고(교육).',
    formula: '잔고 = 시작×(1+r) − 인출',
    fields: [
      CalculatorField(key: 'start', label: '기초 자산', unit: '원'),
      CalculatorField(key: 'ret', label: '가정 수익률', unit: '%'),
      CalculatorField(key: 'wd', label: '인출액', unit: '원'),
    ],
    limitations: ['안전인출률 단정 금지', '다기간·세금 미반영'],
    route: '/tools/withdrawal',
  ),
  CalculatorDefinition(
    id: 'calc-pension-gap-cash',
    title: '연금개시 공백 현금',
    purpose: '수급 전 공백 개월의 현금 필요(교육).',
    formula: '필요 = max(0, 월필요−기타월소득) × 개월',
    fields: [
      CalculatorField(key: 'need', label: '월 필요생활비', unit: '원'),
      CalculatorField(key: 'other', label: '기타 월소득', unit: '원'),
      CalculatorField(key: 'months', label: '공백 개월', unit: '개월'),
    ],
    limitations: ['NPS 공식조회 권장', '의료·세금 별도'],
    route: '/tools/pension-gap-cash',
  ),
  CalculatorDefinition(
    id: 'calc-spouse-cashflow',
    title: '배우자 단독 현금흐름',
    purpose: '소득 중단 가정 시 월 갭(교육).',
    formula: '갭 = 생활비 − (연금+기타)',
    fields: [
      CalculatorField(key: 'living', label: '월 생활비', unit: '원'),
      CalculatorField(key: 'pension', label: '월 연금합', unit: '원'),
      CalculatorField(key: 'other', label: '월 기타소득', unit: '원'),
    ],
    limitations: ['유족·보험은 계약 확인', '예측 아님'],
    route: '/tools/spouse-cashflow',
  ),
  CalculatorDefinition(
    id: 'calc-expense-bands',
    title: '노후생활비 구간',
    purpose: '필수·선택·의료를 구분해 합산합니다.',
    formula: '합계 = 필수+선택+의료(+기타)',
    fields: [
      CalculatorField(key: 'essential', label: '필수생활비', unit: '원/월'),
      CalculatorField(key: 'discretionary', label: '선택생활비', unit: '원/월'),
      CalculatorField(key: 'medical', label: '의료·간병 여유', unit: '원/월'),
    ],
    limitations: ['물가·간병 급증 별도 스트레스'],
    route: '/tools/expense-bands',
  ),
  CalculatorDefinition(
    id: 'calc-care-stress',
    title: '의료·간병 스트레스',
    purpose: '추가 월비용이 현금흐름에 미치는 영향.',
    formula: '조정갭 = (생활비+추가) − 소득',
    fields: [
      CalculatorField(key: 'living', label: '기본 월생활비', unit: '원'),
      CalculatorField(key: 'extra', label: '추가 의료·간병', unit: '원'),
      CalculatorField(key: 'income', label: '월 소득·연금', unit: '원'),
    ],
    limitations: ['보험금 확정 아님'],
    route: '/tools/care-stress',
  ),
  CalculatorDefinition(
    id: 'calc-biz-split',
    title: '사업·개인 현금흐름 분리',
    purpose: '사업순유입과 개인생활비를 구분해 봅니다.',
    formula: '개인여유 = 사업순유입 − 개인생활비 − 개인상환',
    fields: [
      CalculatorField(key: 'biz', label: '사업 월순유입', unit: '원'),
      CalculatorField(key: 'personal', label: '개인 생활비', unit: '원'),
      CalculatorField(key: 'pay', label: '개인 대출상환', unit: '원'),
    ],
    limitations: ['매출≠순유입', '세금 별도'],
    route: '/tools/biz-split',
  ),
  CalculatorDefinition(
    id: 'calc-sequence-multi',
    title: '순서위험 2기간',
    purpose: '인출 중 수익 순서가 잔고에 미치는 교육 비교.',
    formula: '잔고A/B = 수익 순서만 바꾼 2년 인출 후 잔고',
    fields: [
      CalculatorField(key: 'start', label: '시작자산', unit: '원'),
      CalculatorField(key: 'r1', label: '1년 수익', unit: '%'),
      CalculatorField(key: 'r2', label: '2년 수익', unit: '%'),
      CalculatorField(key: 'wd', label: '매년 인출', unit: '원'),
    ],
    limitations: ['교육용', '세금·수수료 없음', '예측 아님'],
    route: '/tools/sequence-multi',
  ),
];

/// 계산기 실행 결과 (교육용)
class CalculatorResult {
  const CalculatorResult({
    required this.summary,
    required this.details,
    this.copyText = '',
  });

  final String summary;
  final List<String> details;
  final String copyText;
}

CalculatorResult? runCalculator(String id, Map<String, double> values) {
  double v(String key) => values[key] ?? 0;

  try {
    switch (id) {
      case 'calc-net-worth':
        final r = FinanceMath.netWorth(
          assets: v('assets'),
          liabilities: v('liabilities'),
        );
        return CalculatorResult(
          summary: '순자산 ${r.round()}원',
          details: [
            '총자산 ${v('assets').round()}원',
            '총부채 ${v('liabilities').round()}원',
            '순자산 = 자산 − 부채',
          ],
          copyText: '순자산: ${r.round()}원',
        );
      case 'calc-cashflow':
        final r = FinanceMath.monthlyCashFlow(
          income: v('income'),
          expenses: v('expenses'),
        );
        return CalculatorResult(
          summary: '월 현금흐름 ${r.round()}원',
          details: ['소득 − 지출'],
          copyText: '월 현금흐름: ${r.round()}원',
        );
      case 'calc-savings-rate':
        final r = FinanceMath.savingsRate(
          income: v('income'),
          savings: v('savings'),
        );
        return CalculatorResult(
          summary: '저축률 ${r.toStringAsFixed(2)}%',
          details: ['저축 ÷ 소득 × 100'],
          copyText: '저축률: ${r.toStringAsFixed(2)}%',
        );
      case 'calc-simple':
        final total = FinanceMath.simpleInterest(
          principal: v('principal'),
          annualRatePercent: v('rate'),
          years: v('years'),
        );
        final earned = total - v('principal');
        return CalculatorResult(
          summary: '만기금액 ${total.round()}원 (이자 ${earned.round()}원)',
          details: ['단리: P×(1+r×t)', '세금 미반영'],
          copyText: '단리 만기: ${total.round()}원',
        );
      case 'calc-compound':
        final n = v('n').round();
        if (n <= 0) {
          throw ArgumentError('연간 복리횟수는 1 이상이어야 합니다.');
        }
        final total = FinanceMath.compoundInterest(
          principal: v('principal'),
          annualRatePercent: v('rate'),
          years: v('years'),
          compoundsPerYear: n,
        );
        return CalculatorResult(
          summary: '복리 만기 ${total.round()}원',
          details: ['A=P(1+r/n)^(n·t)', '연 $n회 복리', '과거≠미래'],
          copyText: '복리 만기: ${total.round()}원',
        );
      case 'calc-real-return':
        final r = FinanceMath.realReturnPercent(
          nominalPercent: v('nominal'),
          inflationPercent: v('inflation'),
        );
        return CalculatorResult(
          summary: '실질수익률 ${r.toStringAsFixed(2)}%',
          details: ['(1+명목)/(1+물가)−1'],
          copyText: '실질수익률: ${r.toStringAsFixed(2)}%',
        );
      case 'calc-loan-payment':
      case 'calc-equal-payment':
        final months = v('months').round();
        final m = FinanceMath.equalPaymentMonthly(
          principal: v('principal'),
          annualRatePercent: v('rate'),
          months: months,
        );
        final interest = FinanceMath.equalPaymentTotalInterest(
          principal: v('principal'),
          annualRatePercent: v('rate'),
          months: months,
        );
        return CalculatorResult(
          summary: '월 ${m.round()}원 / 총이자 ${interest.round()}원',
          details: ['원리금균등', '수수료 미반영'],
          copyText: '월상환 ${m.round()}원, 총이자 ${interest.round()}원',
        );
      case 'calc-equal-principal':
        final months = v('months').round();
        final first = FinanceMath.equalPrincipalFirstPayment(
          principal: v('principal'),
          annualRatePercent: v('rate'),
          months: months,
        );
        final interest = FinanceMath.equalPrincipalTotalInterest(
          principal: v('principal'),
          annualRatePercent: v('rate'),
          months: months,
        );
        final equalM = FinanceMath.equalPaymentMonthly(
          principal: v('principal'),
          annualRatePercent: v('rate'),
          months: months,
        );
        return CalculatorResult(
          summary: '원금균등 첫달 ${first.round()}원, 총이자 ${interest.round()}원',
          details: ['원리금균등 월 ${equalM.round()}원과 비교', '원금균등은 초기에 부담이 더 클 수 있음'],
          copyText: '원금균등 첫달 ${first.round()}원 / 총이자 ${interest.round()}원',
        );
      case 'calc-invest-return':
        final r = FinanceMath.investmentReturnPercent(
          buyAmount: v('buy'),
          sellAmount: v('sell'),
        );
        return CalculatorResult(
          summary: '손익률 ${r.toStringAsFixed(2)}%',
          details: ['수수료·세금 미반영', '과거≠미래'],
          copyText: '손익률: ${r.toStringAsFixed(2)}%',
        );
      case 'calc-rental-yield':
        final r = FinanceMath.rentalYieldPercent(
          annualRent: v('rent'),
          purchasePrice: v('price'),
        );
        return CalculatorResult(
          summary: '단순 임대수익률 ${r.toStringAsFixed(2)}%',
          details: ['공실·세금·이자 미반영'],
          copyText: '임대수익률: ${r.toStringAsFixed(2)}%',
        );
      case 'calc-retirement-gap':
        final r = FinanceMath.retirementGap(
          neededTotal: v('needed'),
          expectedAssets: v('expected'),
        );
        return CalculatorResult(
          summary: r >= 0 ? '부족액 ${r.round()}원' : '여유 ${(-r).round()}원',
          details: ['시나리오별로 다시 계산하세요'],
          copyText: '은퇴자금 차이: ${r.round()}원',
        );
      case 'calc-pension-sum':
        final r = FinanceMath.pensionMonthlySum([
          v('nps'),
          v('retire'),
          v('personal'),
          v('other'),
        ]);
        return CalculatorResult(
          summary: '월 합계 ${r.round()}원',
          details: ['국민연금은 공단 공식 조회 권장', '세금·건보 미반영'],
          copyText: '연금 월합계: ${r.round()}원',
        );
      case 'calc-future-cost':
        final r = FinanceMath.futureLivingCost(
          currentCost: v('current'),
          inflationPercent: v('inflation'),
          years: v('years'),
        );
        return CalculatorResult(
          summary: '미래 월생활비 ${r.round()}원',
          details: ['현재 × (1+물가)^년'],
          copyText: '미래생활비: ${r.round()}원',
        );
      case 'calc-debt-burden':
        final r = FinanceMath.paymentBurdenPercent(
          monthlyPayment: v('payment'),
          monthlyIncome: v('income'),
        );
        return CalculatorResult(
          summary: '상환부담 ${r.toStringAsFixed(2)}%',
          details: ['DSR 대체 아님'],
          copyText: '상환부담: ${r.toStringAsFixed(2)}%',
        );
      case 'calc-emergency-months':
        final r = FinanceMath.emergencyMonths(
          cashLike: v('cash'),
          monthlyEssential: v('essential'),
        );
        return CalculatorResult(
          summary: '약 ${r.toStringAsFixed(1)}개월 충당',
          details: ['직업·부양에 따라 목표 상이', '무조건 N개월 단정 금지'],
          copyText: '비상자금 개월: ${r.toStringAsFixed(1)}',
        );
      case 'calc-net-rent':
        final r = FinanceMath.netRentalCashFlow(
          annualRent: v('rent'),
          annualCosts: v('costs'),
        );
        return CalculatorResult(
          summary: '순임대현금 ${r.round()}원/년',
          details: ['세후 확정 아님'],
          copyText: '순임대: ${r.round()}원',
        );
      case 'calc-acquisition-cost':
        final sum =
            v('price') +
            v('tax') +
            v('broker') +
            v('legal') +
            v('repair') +
            v('other');
        return CalculatorResult(
          summary: '총취득 합계 ${sum.round()}원',
          details: ['세율 미내장', '공식·약정 확인'],
          copyText: '총취득합계: ${sum.round()}원',
        );
      case 'calc-etf-fee':
        final r = FinanceMath.etfCostDragFutureValue(
          principal: v('principal'),
          grossReturnPercent: v('gross'),
          feePercent: v('fee'),
          years: v('years'),
        );
        return CalculatorResult(
          summary: '가정 최종 ${r.round()}원',
          details: ['과거≠미래', '세금·추적오차 미반영'],
          copyText: 'ETF비용반영 최종: ${r.round()}원',
        );
      case 'calc-recovery':
        final r = FinanceMath.recoveryReturnPercent(lossPercent: v('loss'));
        return CalculatorResult(
          summary: '원금 회복에 약 ${r.toStringAsFixed(2)}% 필요',
          details: ['교육용', '투자 권유 아님'],
          copyText: '회복률: ${r.toStringAsFixed(2)}%',
        );
      case 'calc-rate-stress':
        final months = v('months').round();
        final a = FinanceMath.equalPaymentMonthly(
          principal: v('principal'),
          annualRatePercent: v('rate'),
          months: months,
        );
        final b = FinanceMath.equalPaymentMonthly(
          principal: v('principal'),
          annualRatePercent: v('stress'),
          months: months,
        );
        return CalculatorResult(
          summary:
              '현재월 ${a.round()}원 → 스트레스 ${b.round()}원 (차이 ${(b - a).round()}원)',
          details: ['약정·수수료 미반영'],
          copyText: '월상환 ${a.round()} → ${b.round()}',
        );
      case 'calc-vacancy-stress':
        final base = FinanceMath.netRentalCashFlow(
          annualRent: v('rent'),
          annualCosts: v('baseCost'),
        );
        final stressed = FinanceMath.netRentalCashFlow(
          annualRent: v('rent'),
          annualCosts: v('baseCost') + v('extra'),
        );
        return CalculatorResult(
          summary: '기본 순임대 ${base.round()}원 → 스트레스 ${stressed.round()}원',
          details: ['가격전망 없음'],
          copyText: '순임대 ${base.round()} → ${stressed.round()}',
        );
      case 'calc-sequence-risk':
        final y1 = v('principal') * (1 + v('r1') / 100) - v('withdraw');
        final y2 = y1 * (1 + v('r2') / 100) - v('withdraw');
        return CalculatorResult(
          summary: '2년차 잔고 약 ${y2.round()}원',
          details: ['1년차 후 ${y1.round()}원', '단순 2년 예시', '안전인출률 단정 금지'],
          copyText: '순서위험 예시 잔고: ${y2.round()}원',
        );
      case 'calc-variable-income':
        final sum = v('q1') + v('q2') + v('q3') + v('q4');
        return CalculatorResult(
          summary: '합계 ${sum.round()}원 / 구간평균 ${(sum / 4).round()}원',
          details: ['비용·세금 미차감', '매출≠순이익'],
          copyText: '변동소득 합계: ${sum.round()}원',
        );
      case 'calc-retirement-cashflow':
        final gap = v('living') - (v('pension') + v('other'));
        return CalculatorResult(
          summary: gap >= 0
              ? '월 부족 ${gap.round()}원'
              : '월 여유 ${(-gap).round()}원',
          details: ['의료·세금·건보 별도', 'NPS 공식조회 권장'],
          copyText: '은퇴월갭: ${gap.round()}원',
        );
      case 'calc-debt-interest':
        final months = v('months').round();
        final interest = FinanceMath.equalPaymentTotalInterest(
          principal: v('principal'),
          annualRatePercent: v('rate'),
          months: months,
        );
        return CalculatorResult(
          summary: '총이자 ${interest.round()}원',
          details: ['원리금균등 가정'],
          copyText: '총이자: ${interest.round()}원',
        );

      case 'calc-concentration':
        final r = FinanceMath.concentrationPercent(
          focusAmount: v('focus'),
          totalAssets: v('total'),
        );
        return CalculatorResult(
          summary: '집중도 ${r.toStringAsFixed(1)}%',
          details: ['권장비중 아님', '상관·유동성 별도'],
          copyText: '집중도: ${r.toStringAsFixed(1)}%',
        );
      case 'calc-drawdown':
        final r = FinanceMath.maxDrawdownPercent(
          peak: v('peak'),
          trough: v('trough'),
        );
        return CalculatorResult(
          summary: '최대낙폭 ${r.toStringAsFixed(2)}%',
          details: ['과거≠미래'],
          copyText: 'MDD: ${r.toStringAsFixed(2)}%',
        );
      case 'calc-rebalance':
        final r = FinanceMath.rebalanceTradeAmount(
          currentValue: v('current'),
          targetWeightPercent: v('targetW'),
          portfolioValue: v('portfolio'),
        );
        return CalculatorResult(
          summary: r >= 0 ? '매수 필요 ${r.round()}원' : '매도 필요 ${(-r).round()}원',
          details: ['세금·수수료 미반영'],
          copyText: '리밸런싱: ${r.round()}원',
        );
      case 'calc-withdrawal':
        final r = FinanceMath.withdrawalBalance(
          start: v('start'),
          returnPercent: v('ret'),
          withdrawal: v('wd'),
        );
        return CalculatorResult(
          summary: '기말 잔고 ${r.round()}원',
          details: ['안전인출률 단정 금지'],
          copyText: '인출후잔고: ${r.round()}원',
        );
      case 'calc-pension-gap-cash':
        final r = FinanceMath.pensionGapCashNeed(
          monthlyNeed: v('need'),
          months: v('months'),
          otherMonthlyIncome: v('other'),
        );
        return CalculatorResult(
          summary: '공백 현금 ${r.round()}원',
          details: ['NPS 공식조회 권장'],
          copyText: '공백현금: ${r.round()}원',
        );
      case 'calc-spouse-cashflow':
        final gap = v('living') - (v('pension') + v('other'));
        return CalculatorResult(
          summary: gap >= 0 ? '월 갭 ${gap.round()}원' : '월 여유 ${(-gap).round()}원',
          details: ['교육용 가정'],
          copyText: '배우자단독갭: ${gap.round()}원',
        );
      case 'calc-expense-bands':
        final sum = v('essential') + v('discretionary') + v('medical');
        return CalculatorResult(
          summary: '월 합계 ${sum.round()}원',
          details: [
            '필수 ${v("essential").round()}',
            '선택 ${v("discretionary").round()}',
            '의료여유 ${v("medical").round()}',
          ],
          copyText: '생활비합계: ${sum.round()}원',
        );
      case 'calc-care-stress':
        final gap = (v('living') + v('extra')) - v('income');
        return CalculatorResult(
          summary: gap >= 0
              ? '스트레스 갭 ${gap.round()}원'
              : '여유 ${(-gap).round()}원',
          details: ['보험금 미확정'],
          copyText: '간병스트레스갭: ${gap.round()}원',
        );
      case 'calc-biz-split':
        final r = v('biz') - v('personal') - v('pay');
        return CalculatorResult(
          summary: '개인 여유 ${r.round()}원',
          details: ['매출≠순유입'],
          copyText: '개인여유: ${r.round()}원',
        );
      case 'calc-sequence-multi':
        final a1 = FinanceMath.withdrawalBalance(
          start: v('start'),
          returnPercent: v('r1'),
          withdrawal: v('wd'),
        );
        final a2 = FinanceMath.withdrawalBalance(
          start: a1,
          returnPercent: v('r2'),
          withdrawal: v('wd'),
        );
        final b1 = FinanceMath.withdrawalBalance(
          start: v('start'),
          returnPercent: v('r2'),
          withdrawal: v('wd'),
        );
        final b2 = FinanceMath.withdrawalBalance(
          start: b1,
          returnPercent: v('r1'),
          withdrawal: v('wd'),
        );
        return CalculatorResult(
          summary: '순서A ${a2.round()}원 / 순서B ${b2.round()}원',
          details: ['같은 평균이라도 순서가 잔고를 바꿈', '예측 아님'],
          copyText: '순서위험 A:${a2.round()} B:${b2.round()}',
        );
      case 'calc-allocation-shift':
        final w1 = v('w1') / 100;
        final w2 = v('w2') / 100;
        final weighted = w1 * v('r1') + w2 * v('r2');
        return CalculatorResult(
          summary: '가중 가정수익 ${weighted.toStringAsFixed(2)}%',
          details: [
            '비중합 ${(v('w1') + v('w2')).toStringAsFixed(1)}%',
            '권장비율 아님',
            '과거≠미래',
          ],
          copyText: '가중수익: ${weighted.toStringAsFixed(2)}%',
        );
      default:
        return null;
    }
  } catch (e) {
    return CalculatorResult(summary: '계산할 수 없습니다', details: [e.toString()]);
  }
}
