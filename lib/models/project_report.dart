class ProjectReport {
  const ProjectReport({
    required this.phase,
    required this.summary,
    required this.contentCount,
    required this.calculatorCount,
    required this.scenarioCount,
    required this.termCount,
    required this.promptCount,
    required this.sourceCount,
    required this.testStatus,
    required this.commitHash,
    required this.actionsStatus,
    required this.firebaseProjectId,
    required this.hostingUrl,
    required this.remainingReviews,
    required this.phase2Plan,
    required this.phase3Plan,
  });

  final String phase;
  final String summary;
  final int contentCount;
  final int calculatorCount;
  final int scenarioCount;
  final int termCount;
  final int promptCount;
  final int sourceCount;
  final String testStatus;
  final String commitHash;
  final String actionsStatus;
  final String firebaseProjectId;
  final String hostingUrl;
  final List<String> remainingReviews;
  final List<String> phase2Plan;
  final List<String> phase3Plan;

  String toMarkdown() {
    final buf = StringBuffer()
      ..writeln('# SotongFinance 1단계 완료 보고')
      ..writeln()
      ..writeln('## 작업 단계')
      ..writeln(phase)
      ..writeln()
      ..writeln('## 변경 요약')
      ..writeln(summary)
      ..writeln()
      ..writeln('## 콘텐츠 수')
      ..writeln('- 학습 콘텐츠: $contentCount')
      ..writeln('- 계산기: $calculatorCount')
      ..writeln('- 사례: $scenarioCount')
      ..writeln('- 용어: $termCount')
      ..writeln('- 프롬프트: $promptCount')
      ..writeln('- 공식 출처: $sourceCount')
      ..writeln()
      ..writeln('## 테스트')
      ..writeln(testStatus)
      ..writeln()
      ..writeln('## 커밋')
      ..writeln(commitHash)
      ..writeln()
      ..writeln('## Actions')
      ..writeln(actionsStatus)
      ..writeln()
      ..writeln('## Firebase')
      ..writeln('- Project ID: $firebaseProjectId')
      ..writeln('- 운영 주소: $hostingUrl')
      ..writeln()
      ..writeln('## 남은 검토')
      ..writeln(remainingReviews.map((e) => '- $e').join('\n'))
      ..writeln()
      ..writeln('## 2단계 계획')
      ..writeln(phase2Plan.map((e) => '- $e').join('\n'))
      ..writeln()
      ..writeln('## 3단계 계획')
      ..writeln(phase3Plan.map((e) => '- $e').join('\n'));
    return buf.toString();
  }
}
