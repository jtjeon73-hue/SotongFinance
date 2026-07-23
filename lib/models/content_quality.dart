enum ContentQualityGrade { a, b, c, d }

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

class ContentQualityEntry {
  const ContentQualityEntry({
    required this.id,
    required this.grade,
    required this.reason,
  });

  final String id;
  final ContentQualityGrade grade;
  final String reason;
}
