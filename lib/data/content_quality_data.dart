import '../models/content_quality.dart';
import 'content_catalog.dart';
import 'phase2_upgraded_ids.dart';

/// 글자수가 아니라 구조·실무성·출처·체크리스트로 평가한 등급.
/// Phase2 보강분은 A/B, 템플릿 잔여분은 대체로 C, 매우 빈약한 경우 D.
final Map<String, ContentQualityEntry> contentQualityMap = {
  for (final c in allFinanceContent)
    c.id: _grade(
      c.id,
      c.sections.length,
      c.checklist.isNotEmpty,
      c.sourceIds.isNotEmpty,
    ),
};

ContentQualityEntry _grade(
  String id,
  int sections,
  bool checklist,
  bool sources,
) {
  if (phase2UpgradedIds.contains(id)) {
    return ContentQualityEntry(
      id: id,
      grade: ContentQualityGrade.a,
      reason: '2단계 수동 보강: 실무 절차·위험·체크리스트·기준일 포함',
    );
  }
  if (sections >= 6 && checklist && sources) {
    return ContentQualityEntry(
      id: id,
      grade: ContentQualityGrade.b,
      reason: '기본 학습 + 일부 실무 요소',
    );
  }
  if (sections <= 4 || !checklist) {
    return ContentQualityEntry(
      id: id,
      grade: ContentQualityGrade.d,
      reason: '내용 부족·템플릿 반복·보강 필요',
    );
  }
  return ContentQualityEntry(
    id: id,
    grade: ContentQualityGrade.c,
    reason: '개념·소개 중심(1단계 템플릿)',
  );
}

ContentQualityGrade gradeFor(String id) =>
    contentQualityMap[id]?.grade ?? ContentQualityGrade.d;

Map<ContentQualityGrade, int> countByGrade() {
  final m = <ContentQualityGrade, int>{
    for (final g in ContentQualityGrade.values) g: 0,
  };
  for (final e in contentQualityMap.values) {
    m[e.grade] = (m[e.grade] ?? 0) + 1;
  }
  return m;
}

List<String> idsWithGrade(ContentQualityGrade g) =>
    contentQualityMap.entries
        .where((e) => e.value.grade == g)
        .map((e) => e.key)
        .toList()
      ..sort();
