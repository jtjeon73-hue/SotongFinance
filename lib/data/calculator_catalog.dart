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
      default:
        return null;
    }
  } catch (e) {
    return CalculatorResult(summary: '계산할 수 없습니다', details: [e.toString()]);
  }
}
