class CrisisEvent {
  const CrisisEvent({
    required this.id,
    required this.title,
    required this.immediate,
    required this.stopDoing,
    required this.cashCheck,
    required this.contacts,
    required this.evidence,
    required this.family,
    required this.recovery,
  });

  final String id;
  final String title;
  final List<String> immediate;
  final List<String> stopDoing;
  final List<String> cashCheck;
  final List<String> contacts;
  final List<String> evidence;
  final List<String> family;
  final List<String> recovery;
}

const crisisEvents = <CrisisEvent>[
  CrisisEvent(
    id: 'job-loss',
    title: '실직',
    immediate: ['필수비 재산정', '실업·공공지원 공식 확인', '고금리 부채 점검'],
    stopDoing: ['신규 위험투자', '충동 대출'],
    cashCheck: ['비상자금', '미사용 한도'],
    contacts: ['금융회사(약정)', '공식 고용·복지 안내'],
    evidence: ['근로·퇴직 서류'],
    family: ['생활비 조정 합의'],
    recovery: ['재취업·지출계획', '보험 유지 여부 질문'],
  ),
  CrisisEvent(
    id: 'sales-drop',
    title: '매출 급감·사업중단',
    immediate: ['개인/사업 계좌 분리 확인', '고정비·인건비 재검토'],
    stopDoing: ['매출을 소득으로 착각한 지출'],
    cashCheck: ['운영비상자금', '세금 납부 일정'],
    contacts: ['국세청 공식', '금융회사'],
    evidence: ['매출·비용 기록'],
    family: ['가정생활비 분리'],
    recovery: ['비수기 달력 갱신'],
  ),
  CrisisEvent(
    id: 'rate-spike',
    title: '금리상승',
    immediate: ['월상환 스트레스 계산', '변동/고정 약정 확인'],
    stopDoing: ['추가 레버리지'],
    cashCheck: ['상환여력', '비상자금'],
    contacts: ['금융회사 상담(상품권유 주의)'],
    evidence: ['약정서'],
    family: ['생활비 조정'],
    recovery: ['대환·기간 재검토(수수료 포함)'],
  ),
  CrisisEvent(
    id: 'market-loss',
    title: '큰 투자손실',
    immediate: ['IPS·목표 재확인', '필수자금 분리 여부 점검'],
    stopDoing: ['복수매매', '레버리지 확대'],
    cashCheck: ['생활비 12개월 여부'],
    contacts: ['공식 투자자 보호 안내'],
    evidence: ['매매·잔고 기록'],
    family: ['감정적 결정 보류'],
    recovery: ['리밸런싱·인출 규칙 재검토'],
  ),
  CrisisEvent(
    id: 'voice-phishing',
    title: '보이스피싱·계정탈취',
    immediate: ['송금 중단', '통화 종료', '공식 채널로 재확인'],
    stopDoing: ['전화로 받은 번호로 재연결', '원격앱 설치'],
    cashCheck: ['계좌·카드 정지 공식절차'],
    contacts: ['금융회사', '경찰·금감원 공식'],
    evidence: ['문자·계좌·앱 기록'],
    family: ['공유·주의'],
    recovery: ['비밀번호 변경', '재발 방지 교육'],
  ),
  CrisisEvent(
    id: 'spouse-death',
    title: '배우자 사망',
    immediate: ['장례·행정', '계좌·보험·연금 수익자 확인'],
    stopDoing: ['성급 매각·투자'],
    cashCheck: ['생활비·보험금·연금'],
    contacts: ['보험·연금 공식', '법률·세무 전문가'],
    evidence: ['가족관계·계약'],
    family: ['상속·돌봄 논의'],
    recovery: ['단독 현금흐름표', '문서 정리'],
  ),
  CrisisEvent(
    id: 'care-cost',
    title: '중병·간병',
    immediate: ['의료비·간병비 추정', '보험 약관 확인'],
    stopDoing: ['고변동 자산 강제 매도 충동만으로 결정'],
    cashCheck: ['현금성·보험'],
    contacts: ['병원·보험 공식', '공공지원 공식'],
    evidence: ['진단·청구 서류'],
    family: ['돌봄 역할'],
    recovery: ['장기 현금흐름 재설계'],
  ),
];

String crisisMarkdown(CrisisEvent e) {
  final b = StringBuffer()
    ..writeln('# 위기대응: ${e.title}')
    ..writeln()
    ..writeln('교육용 런북입니다. 미검증 전화번호는 적지 마세요.')
    ..writeln()
    ..writeln('## 즉시 할 일')
    ..writeln(e.immediate.map((x) => '- $x').join('\n'))
    ..writeln()
    ..writeln('## 중단할 일')
    ..writeln(e.stopDoing.map((x) => '- $x').join('\n'))
    ..writeln()
    ..writeln('## 현금 확인')
    ..writeln(e.cashCheck.map((x) => '- $x').join('\n'))
    ..writeln()
    ..writeln('## 연락·공식확인')
    ..writeln(e.contacts.map((x) => '- $x').join('\n'))
    ..writeln()
    ..writeln('## 증거')
    ..writeln(e.evidence.map((x) => '- $x').join('\n'))
    ..writeln()
    ..writeln('## 가족')
    ..writeln(e.family.map((x) => '- $x').join('\n'))
    ..writeln()
    ..writeln('## 정상화')
    ..writeln(e.recovery.map((x) => '- $x').join('\n'));
  return b.toString();
}
