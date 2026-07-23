/// 교육용 투자정책서(IPS) 템플릿 — 수익 보장·권장비율 아님
class IpsField {
  const IpsField({required this.id, required this.label, required this.hint});
  final String id;
  final String label;
  final String hint;
}

const ipsTemplateFields = <IpsField>[
  IpsField(id: 'purpose', label: '투자 목적', hint: '예: 은퇴 보완, 주택 자금(익명)'),
  IpsField(id: 'horizon', label: '목표기간', hint: '년 단위'),
  IpsField(id: 'amount', label: '필요한 금액', hint: '원(대략)'),
  IpsField(id: 'contribution', label: '납입계획', hint: '월/연'),
  IpsField(id: 'cashflow', label: '현금흐름', hint: '흑자/적자·안정성'),
  IpsField(id: 'emergency', label: '비상자금', hint: '개월·보관장소'),
  IpsField(id: 'debt', label: '부채', hint: '금리·상환'),
  IpsField(id: 'lossTolerance', label: '허용 손실', hint: '% 또는 금액(가정)'),
  IpsField(id: 'riskCapacity', label: '위험감수능력', hint: '재무적으로 견딜 수 있는 손실'),
  IpsField(id: 'riskAttitude', label: '위험감수성향', hint: '심리적 불안 정도'),
  IpsField(id: 'liquidity', label: '유동성', hint: '언제 현금화해야 하는지'),
  IpsField(id: 'tax', label: '세금', hint: '계좌유형·확인 필요사항'),
  IpsField(id: 'constraints', label: '법적·개인적 제약', hint: '건강·부양·직업'),
  IpsField(id: 'allowed', label: '허용 자산', hint: '유형만, 종목 추천 금지'),
  IpsField(id: 'forbidden', label: '금지 자산', hint: '레버·복잡상품 등'),
  IpsField(id: 'targetAlloc', label: '목표 자산배분', hint: '직접 기입, 기본정답 없음'),
  IpsField(id: 'band', label: '허용범위', hint: '예: ±5%p'),
  IpsField(id: 'rebalance', label: '리밸런싱 조건', hint: '정기/범위/현금유입'),
  IpsField(id: 'benchmark', label: '성과 비교 기준', hint: '목표 진행도 우선'),
  IpsField(id: 'review', label: '점검주기', hint: '분기/반기/연'),
  IpsField(id: 'change', label: '계획 변경조건', hint: '소득·가족·건강 변화'),
];

const ipsDisclaimer =
    '투자정책서는 수익을 보장하는 문서가 아닙니다. '
    '감정적 투자변경을 줄이고 일관된 의사결정을 돕는 교육용 도구입니다. '
    '특정 비율·상품을 기본 정답으로 제시하지 않습니다. '
    '입력값은 서버에 저장되지 않습니다.';

String buildIpsMarkdown(Map<String, String> values) {
  final buf = StringBuffer()
    ..writeln('# 교육용 투자정책서(IPS)')
    ..writeln()
    ..writeln(ipsDisclaimer)
    ..writeln();
  for (final f in ipsTemplateFields) {
    final v = values[f.id]?.trim();
    buf.writeln('## ${f.label}');
    buf.writeln(v == null || v.isEmpty ? '(미기입)' : v);
    buf.writeln();
  }
  return buf.toString();
}
