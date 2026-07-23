class PolicyTimelineItem {
  const PolicyTimelineItem({
    required this.id,
    required this.area,
    required this.name,
    required this.status,
    required this.note,
    required this.sourceId,
    this.announcedOn,
    this.effectiveOn,
    this.reviewDueAt = '2026-08-23',
  });

  final String id;
  final String area;
  final String name;

  /// announced | effective | transitional | draftUnconfirmed
  final String status;
  final String note;
  final String sourceId;
  final String? announcedOn;
  final String? effectiveOn;
  final String reviewDueAt;
}

const policyTimeline = <PolicyTimelineItem>[
  PolicyTimelineItem(
    id: 'tl-tax-check',
    area: '세금',
    name: '세법·신고 제도(일반)',
    status: 'effective',
    note: '세율·공제는 연도·상황에 따라 달라집니다. 국세청에서 재확인.',
    sourceId: 'src-nts',
  ),
  PolicyTimelineItem(
    id: 'tl-nps',
    area: '국민연금',
    name: '국민연금 가입·수급 제도',
    status: 'effective',
    note: '예상액은 공단 공식 조회. 앱 임의 추정 금지.',
    sourceId: 'src-nps',
  ),
  PolicyTimelineItem(
    id: 'tl-retire',
    area: '퇴직·개인연금',
    name: '퇴직연금·연금저축·IRP',
    status: 'effective',
    note: '세제·중도·수령은 계약·규정에 따름. versionDependent.',
    sourceId: 'src-fss',
  ),
  PolicyTimelineItem(
    id: 'tl-kdic',
    area: '예금자보호',
    name: '예금자보호 한도·대상',
    status: 'effective',
    note: '한도·대상은 변경될 수 있음. 예금보험공사 확인.',
    sourceId: 'src-kdic',
  ),
  PolicyTimelineItem(
    id: 'tl-loan',
    area: '대출규제',
    name: 'LTV·DSR 등 대출 규제',
    status: 'effective',
    note: '규제 수치는 앱에 고정하지 않음. 금융회사·정책 공지 확인.',
    sourceId: 'src-fss',
  ),
  PolicyTimelineItem(
    id: 'tl-estate',
    area: '부동산',
    name: '부동산 세금·임대 제도',
    status: 'effective',
    note: '취득·보유·양도는 사실관계·시점에 따라 다름.',
    sourceId: 'src-molit',
  ),
  PolicyTimelineItem(
    id: 'tl-draft',
    area: '금융상품 과세',
    name: '미확정 법안·정책 일반 주의',
    status: 'draftUnconfirmed',
    note: '확정되지 않은 법안을 시행으로 표시하지 않습니다.',
    sourceId: 'src-law',
  ),
];
