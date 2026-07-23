enum ContentQualityGrade { a, b, c, d }

enum ContentKind {
  concept,
  procedure,
  compare,
  checklist,
  scenario,
  taxRegime,
  glossary,
  fraud,
  officialSource,
  calculatorGuide,
  lifePath,
}

extension ContentQualityGradeLabel on ContentQualityGrade {
  String get label => switch (this) {
    ContentQualityGrade.a => 'A',
    ContentQualityGrade.b => 'B',
    ContentQualityGrade.c => 'C',
    ContentQualityGrade.d => 'D',
  };

  String get description => switch (this) {
    ContentQualityGrade.a => '실제 재무 의사결정 전 점검자료 수준',
    ContentQualityGrade.b => '기본 학습과 일부 실무 적용 가능',
    ContentQualityGrade.c => '개념·소개 중심',
    ContentQualityGrade.d => '내용 부족·반복·검증 필요',
  };
}

extension ContentKindLabel on ContentKind {
  String get label => switch (this) {
    ContentKind.concept => '개념',
    ContentKind.procedure => '절차',
    ContentKind.compare => '비교',
    ContentKind.checklist => '체크리스트',
    ContentKind.scenario => '사례',
    ContentKind.taxRegime => '세금·제도',
    ContentKind.glossary => '용어',
    ContentKind.fraud => '사기예방',
    ContentKind.officialSource => '공식자료',
    ContentKind.calculatorGuide => '계산기 안내',
    ContentKind.lifePath => '생애주기',
  };
}

class ContentQualityEntry {
  const ContentQualityEntry({
    required this.id,
    required this.grade,
    required this.reason,
    this.kind = ContentKind.concept,
  });

  final String id;
  final ContentQualityGrade grade;
  final String reason;
  final ContentKind kind;
}
