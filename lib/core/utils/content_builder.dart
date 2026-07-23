import '../../models/enums.dart';
import '../../models/finance_content.dart';

FinanceContent buildLesson({
  required String id,
  required String title,
  required String summary,
  required String category,
  required List<ContentSection> sections,
  Difficulty difficulty = Difficulty.intro,
  ContentType contentType = ContentType.concept,
  List<String> keywords = const [],
  List<String> relatedIds = const [],
  List<String> sourceIds = const [],
  List<LifeStage> lifeStages = const [],
  VerificationStatus verificationStatus = VerificationStatus.educationalExample,
  List<String> checklist = const [],
  List<String> nextActions = const [],
  List<String> commonMistakes = const [],
  String? reviewCycle,
  String referenceYear = '2026',
  String checkedAt = '2026-07-23',
  String reviewDueAt = '2026-10-23',
}) {
  return FinanceContent(
    id: id,
    title: title,
    summary: summary,
    category: category,
    difficulty: difficulty,
    contentType: contentType,
    sections: sections,
    keywords: keywords,
    relatedIds: relatedIds,
    sourceIds: sourceIds,
    lifeStages: lifeStages,
    verificationStatus: verificationStatus,
    checklist: checklist,
    nextActions: nextActions,
    commonMistakes: commonMistakes,
    reviewCycle: reviewCycle,
    referenceYear: referenceYear,
    checkedAt: checkedAt,
    reviewDueAt: reviewDueAt,
    educationalDisclaimer: '교육용 설명입니다. 개인 상황에 따라 결과가 달라지며 수익을 보장하지 않습니다.',
  );
}

ContentSection section(
  String heading,
  String body, {
  List<String> bullets = const [],
  ContentType type = ContentType.concept,
}) =>
    ContentSection(heading: heading, body: body, bullets: bullets, type: type);
