import 'dart:convert';
import 'dart:io';

import 'package:sotong_finance/data/content_catalog.dart';
import 'package:sotong_finance/data/content_quality_data.dart';
import 'package:sotong_finance/models/content_quality.dart';
import 'package:sotong_finance/models/enums.dart';

String inferType(String id, String category, ContentType ct) {
  if (id.startsWith('fraud-')) return '사기예방';
  if (id.startsWith('tax-') || category.contains('세금')) return '세금·제도';
  if (ct == ContentType.glossary || id.contains('term')) return '용어';
  if (id.startsWith('econ-') || category.contains('경제')) return '개념';
  if (ct == ContentType.checklist || id.contains('checklist')) return '체크리스트';
  if (ct == ContentType.scenario) return '사례';
  if (ct == ContentType.actionGuide || id.contains('review')) return '절차';
  if (id.contains('vs') || id.contains('compare') || id.contains('buy-rent')) {
    return '비교';
  }
  if (id.startsWith('calc') || category.contains('계산')) return '계산기 안내';
  return '개념';
}

void main() {
  final cd = <Map<String, Object?>>[];
  for (final g in [ContentQualityGrade.c, ContentQualityGrade.d]) {
    for (final id in idsWithGrade(g)) {
      final c = getById(id)!;
      cd.add({
        'id': id,
        'grade': g.name.toUpperCase(),
        'title': c.title,
        'category': c.category,
        'contentType': c.contentType.name,
        'inferredKind': inferType(id, c.category, c.contentType),
        'sections': c.sections.length,
        'checklist': c.checklist.isNotEmpty,
        'sources': c.sourceIds.isNotEmpty,
        'priorityHints': _priority(id, c.category),
      });
    }
  }
  final byKind = <String, int>{};
  for (final e in cd) {
    final k = e['inferredKind'] as String;
    byKind[k] = (byKind[k] ?? 0) + 1;
  }
  final out = {
    'generatedAt': DateTime.now().toIso8601String(),
    'totalCd': cd.length,
    'byKind': byKind,
    'items': cd,
  };
  File('docs/cd-content-analysis.json')
      .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(out));
  stdout.writeln('wrote docs/cd-content-analysis.json items=${cd.length}');
  for (final e in byKind.entries) {
    stdout.writeln('${e.key}: ${e.value}');
  }
}

List<String> _priority(String id, String category) {
  final hints = <String>[];
  if (id.contains('basics-') || id.endsWith('-basics') || id.contains('overview')) {
    hints.add('선수지식/첫페이지');
  }
  if (id.contains('diversif') || id.contains('allocation') || id.contains('portfolio')) {
    hints.add('자산배분');
  }
  if (id.startsWith('stock') || id.startsWith('etf') || id.startsWith('bond') || id.startsWith('gold')) {
    hints.add('투자위험');
  }
  if (id.startsWith('re-') || id.startsWith('loan-')) hints.add('부동산·대출');
  if (id.startsWith('tax-')) hints.add('세금');
  if (id.startsWith('pension-')) hints.add('연금·은퇴');
  if (id.startsWith('insurance-') || id.startsWith('ins-')) hints.add('보험');
  if (id.startsWith('fraud-')) hints.add('금융사기');
  if (id.contains('variable') || id.contains('farm') || id.contains('self')) {
    hints.add('농민·자영업');
  }
  if (id.startsWith('econ-')) hints.add('경제지표');
  if (id.contains('couple') || id.contains('family') || id.contains('spouse')) {
    hints.add('배우자·가족');
  }
  return hints;
}
