import '../models/content_quality.dart';
import '../models/enums.dart';
import '../models/finance_content.dart';
import 'content_catalog.dart';
import 'phase2_upgraded_ids.dart';
import 'phase3_upgraded_ids.dart';

/// 유형별 품질조건 + 수동 보강분. 글자수·키워드로 승급하지 않음.
final Map<String, ContentQualityEntry> contentQualityMap = {
  for (final c in allFinanceContent) c.id: _grade(c),
};

ContentQualityEntry _grade(FinanceContent c) {
  final id = c.id;
  final kind = inferContentKind(id, c.category, c.contentType);

  if (phase3UpgradedIds.contains(id) || phase2UpgradedIds.contains(id)) {
    return ContentQualityEntry(
      id: id,
      grade: ContentQualityGrade.a,
      reason: phase3UpgradedIds.contains(id)
          ? '3단계 수동 보강: 전문가 점검·위험·공식확인 포함'
          : '2단계 수동 보강: 실무 절차·위험·체크리스트·기준일 포함',
      kind: kind,
    );
  }

  final sections = c.sections.length;
  final checklist = c.checklist.isNotEmpty;
  final sources = c.sourceIds.isNotEmpty;

  if (kind == ContentKind.glossary) {
    if (sections >= 3 && sources) {
      return ContentQualityEntry(
        id: id,
        grade: ContentQualityGrade.b,
        reason: '용어: 정의·연결·출처가 충분',
        kind: kind,
      );
    }
    return ContentQualityEntry(
      id: id,
      grade: ContentQualityGrade.c,
      reason: '용어: 보강·연결 필요',
      kind: kind,
    );
  }

  if (kind == ContentKind.officialSource ||
      kind == ContentKind.calculatorGuide) {
    if (sources && sections >= 4) {
      return ContentQualityEntry(
        id: id,
        grade: ContentQualityGrade.b,
        reason: '안내형: 공식확인·한계 표시',
        kind: kind,
      );
    }
  }

  if (sections >= 6 && checklist && sources) {
    return ContentQualityEntry(
      id: id,
      grade: ContentQualityGrade.b,
      reason: '기본 학습 + 일부 실무 요소',
      kind: kind,
    );
  }
  if (sections <= 4 || !checklist) {
    return ContentQualityEntry(
      id: id,
      grade: ContentQualityGrade.d,
      reason: '내용 부족·템플릿 반복·보강 필요',
      kind: kind,
    );
  }
  return ContentQualityEntry(
    id: id,
    grade: ContentQualityGrade.c,
    reason: '개념·소개 중심',
    kind: kind,
  );
}

ContentKind inferContentKind(String id, String category, ContentType ct) {
  if (id.startsWith('fraud-')) return ContentKind.fraud;
  if (id.startsWith('tax-') || category.contains('세금')) {
    return ContentKind.taxRegime;
  }
  if (ct == ContentType.glossary) return ContentKind.glossary;
  if (ct == ContentType.checklist || id.contains('checklist')) {
    return ContentKind.checklist;
  }
  if (ct == ContentType.scenario) return ContentKind.scenario;
  if (ct == ContentType.actionGuide) return ContentKind.procedure;
  if (id.contains('vs') || id.contains('compare') || id.contains('buy-rent')) {
    return ContentKind.compare;
  }
  return ContentKind.concept;
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

Map<ContentKind, int> countCdByKind() {
  final m = <ContentKind, int>{for (final k in ContentKind.values) k: 0};
  for (final e in contentQualityMap.values) {
    if (e.grade == ContentQualityGrade.c || e.grade == ContentQualityGrade.d) {
      m[e.kind] = (m[e.kind] ?? 0) + 1;
    }
  }
  return m;
}

List<String> idsWithGrade(ContentQualityGrade g) =>
    contentQualityMap.entries
        .where((e) => e.value.grade == g)
        .map((e) => e.key)
        .toList()
      ..sort();
