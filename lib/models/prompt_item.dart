class PromptItem {
  const PromptItem({
    required this.id,
    required this.title,
    required this.purpose,
    required this.requiredInputs,
    required this.promptText,
    required this.doNotGuess,
    required this.officialChecks,
    this.referenceDate = '2026-07-23',
    this.needsProfessionalReview = true,
    this.privacyNote =
        '주민등록번호, 계좌번호, 비밀번호, 실제 보유종목 등 민감정보는 제거하고 익명화한 숫자만 입력하세요.',
    this.interpretationLimit =
        'AI 결과는 교육용 정리입니다. 세금·법률·투자 의사결정은 공식자료와 전문가 확인이 필요합니다.',
  });

  final String id;
  final String title;
  final String purpose;
  final List<String> requiredInputs;
  final String promptText;
  final List<String> doNotGuess;
  final List<String> officialChecks;
  final String referenceDate;
  final bool needsProfessionalReview;
  final String privacyNote;
  final String interpretationLimit;
}
