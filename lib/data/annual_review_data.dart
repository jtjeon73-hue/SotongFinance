const annualReviewItems = <String>[
  '가족 변화',
  '소득',
  '지출',
  '순자산',
  '부채',
  '비상자금',
  '보험',
  '투자·IPS',
  '자산배분·집중도',
  '목표 진행(수익보다)',
  '부동산',
  '세금 준비',
  '국민연금 공식조회',
  '퇴직·개인연금',
  '수익자·명의',
  '중요문서·계정(비밀번호 제외)',
  '사기예방 점검',
  '다음 해 계획',
];

String annualReviewMarkdown(Set<String> checked, {String notes = ''}) {
  final b = StringBuffer()
    ..writeln('# 연간 금융점검표 (교육용·비저장)')
    ..writeln()
    ..writeln('서버에 저장하지 않습니다. 로컬에서만 기록하세요.')
    ..writeln();
  for (final item in annualReviewItems) {
    final mark = checked.contains(item) ? 'x' : ' ';
    b.writeln('- [$mark] $item');
  }
  if (notes.trim().isNotEmpty) {
    b.writeln();
    b.writeln('## 메모');
    b.writeln(notes.trim());
  }
  return b.toString();
}

const estateListFields = <String>[
  '가족관계(요약)',
  '현금·예금',
  '투자자산',
  '부동산',
  '사업·농업자산',
  '연금·보험',
  '디지털자산(계정 목록만)',
  '부채·보증',
  '사전증여 메모',
  '납부재원',
  '유언·의료의향(여부만)',
  '전문가 상담 예정',
];

String estateListMarkdown(Map<String, String> values) {
  final b = StringBuffer()
    ..writeln('# 상속재산 목록 도구 (교육용)')
    ..writeln()
    ..writeln('법률·세금 자문을 대체하지 않습니다. 세액을 확정하지 않습니다.')
    ..writeln();
  for (final f in estateListFields) {
    b.writeln('## $f');
    b.writeln(
      values[f]?.trim().isNotEmpty == true ? values[f]!.trim() : '(미기입)',
    );
    b.writeln();
  }
  return b.toString();
}
