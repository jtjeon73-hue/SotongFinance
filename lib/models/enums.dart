enum Difficulty { intro, basic, practical, expert }

enum ContentType {
  concept,
  calculation,
  risk,
  tax,
  officialCheck,
  scenario,
  actionGuide,
  professionalReview,
  checklist,
  glossary,
}

enum LifeStage {
  newGraduate,
  employee,
  selfEmployed,
  farmer,
  family,
  midCareer,
  preRetirement,
  retired,
}

enum VerificationStatus {
  verified,
  versionDependent,
  needsReview,
  officialCalculatorRecommended,
  professionalReviewRequired,
  educationalExample,
}

/// 출처 상태와 별개로, 개인 적용 검증 상태
enum ApplicationValidationStatus {
  notApplicable,
  deskReviewed,
  calculationValidated,
  officialCalculatorRequired,
  professionalReviewRequired,
  userSituationRequired,
}

extension DifficultyLabel on Difficulty {
  String get label => switch (this) {
    Difficulty.intro => '입문',
    Difficulty.basic => '기초',
    Difficulty.practical => '실무',
    Difficulty.expert => '전문가',
  };
}

extension ContentTypeLabel on ContentType {
  String get label => switch (this) {
    ContentType.concept => '핵심개념',
    ContentType.calculation => '계산',
    ContentType.risk => '위험',
    ContentType.tax => '세금',
    ContentType.officialCheck => '공식 확인',
    ContentType.scenario => '사례',
    ContentType.actionGuide => '행동지침',
    ContentType.professionalReview => '전문가 확인',
    ContentType.checklist => '체크리스트',
    ContentType.glossary => '용어',
  };
}

extension LifeStageLabel on LifeStage {
  String get label => switch (this) {
    LifeStage.newGraduate => '사회초년생',
    LifeStage.employee => '직장인',
    LifeStage.selfEmployed => '자영업자',
    LifeStage.farmer => '농민',
    LifeStage.family => '가족',
    LifeStage.midCareer => '중장년',
    LifeStage.preRetirement => '은퇴 준비',
    LifeStage.retired => '은퇴 후',
  };
}

extension VerificationStatusLabel on VerificationStatus {
  String get label => switch (this) {
    VerificationStatus.verified => 'verified',
    VerificationStatus.versionDependent => 'versionDependent',
    VerificationStatus.needsReview => 'needsReview',
    VerificationStatus.officialCalculatorRecommended =>
      'officialCalculatorRecommended',
    VerificationStatus.professionalReviewRequired =>
      'professionalReviewRequired',
    VerificationStatus.educationalExample => 'educationalExample',
  };
}

extension ApplicationValidationStatusLabel on ApplicationValidationStatus {
  String get label => switch (this) {
    ApplicationValidationStatus.notApplicable => 'notApplicable',
    ApplicationValidationStatus.deskReviewed => 'deskReviewed',
    ApplicationValidationStatus.calculationValidated => 'calculationValidated',
    ApplicationValidationStatus.officialCalculatorRequired =>
      'officialCalculatorRequired',
    ApplicationValidationStatus.professionalReviewRequired =>
      'professionalReviewRequired',
    ApplicationValidationStatus.userSituationRequired =>
      'userSituationRequired',
  };
}
