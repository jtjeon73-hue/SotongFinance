import 'enums.dart';

class ContentSection {
  const ContentSection({
    required this.heading,
    required this.body,
    this.bullets = const [],
    this.type = ContentType.concept,
  });

  final String heading;
  final String body;
  final List<String> bullets;
  final ContentType type;
}

class FinanceContent {
  const FinanceContent({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.difficulty,
    required this.contentType,
    required this.sections,
    this.keywords = const [],
    this.relatedIds = const [],
    this.sourceIds = const [],
    this.lifeStages = const [],
    this.referenceYear = '2026',
    this.checkedAt = '2026-07-23',
    this.reviewDueAt = '2026-10-23',
    this.verificationStatus = VerificationStatus.educationalExample,
    this.educationalDisclaimer,
    this.checklist = const [],
    this.nextActions = const [],
    this.commonMistakes = const [],
    this.reviewCycle,
  });

  final String id;
  final String title;
  final String summary;
  final String category;
  final Difficulty difficulty;
  final ContentType contentType;
  final List<ContentSection> sections;
  final List<String> keywords;
  final List<String> relatedIds;
  final List<String> sourceIds;
  final List<LifeStage> lifeStages;
  final String referenceYear;
  final String checkedAt;
  final String reviewDueAt;
  final VerificationStatus verificationStatus;
  final String? educationalDisclaimer;
  final List<String> checklist;
  final List<String> nextActions;
  final List<String> commonMistakes;
  final String? reviewCycle;

  bool get needsReview {
    final due = DateTime.tryParse(reviewDueAt);
    if (due == null) return false;
    return DateTime.now().isAfter(due);
  }
}
