import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_finance/core/utils/formatters.dart';
import 'package:sotong_finance/data/calculator_catalog.dart';
import 'package:sotong_finance/data/content_catalog.dart';
import 'package:sotong_finance/data/content_id_mapping.dart';
import 'package:sotong_finance/data/nav_data.dart';
import 'package:sotong_finance/data/prompt_data.dart';
import 'package:sotong_finance/data/scenario_data.dart';
import 'package:sotong_finance/data/source_data.dart';
import 'package:sotong_finance/data/term_data.dart';

void main() {
  test('content ids are unique and non-empty', () {
    final ids = <String>{};
    for (final c in allFinanceContent) {
      expect(c.id.trim(), isNotEmpty);
      expect(c.title.trim(), isNotEmpty);
      expect(c.summary.trim(), isNotEmpty);
      expect(c.sections, isNotEmpty);
      for (final s in c.sections) {
        expect(s.heading.trim(), isNotEmpty);
        expect(s.body.trim(), isNotEmpty);
      }
      expect(ids.add(c.id), isTrue, reason: 'duplicate id ${c.id}');
    }
  });

  test('related ids resolve when present', () {
    for (final c in allFinanceContent) {
      for (final r in c.relatedIds) {
        expect(getById(r), isNotNull, reason: '${c.id} related $r missing');
      }
    }
  });

  test('source ids resolve when present', () {
    final sourceIds = officialSources.map((e) => e.id).toSet();
    for (final c in allFinanceContent) {
      for (final s in c.sourceIds) {
        expect(sourceIds.contains(s), isTrue, reason: '${c.id} -> $s');
      }
    }
  });

  test('official source urls are https', () {
    for (final s in officialSources) {
      expect(isValidUrl(s.url), isTrue, reason: s.id);
      expect(s.url.startsWith('https://'), isTrue);
    }
  });

  test('nav learn contentIds resolve via mapping', () {
    for (final g in appNavGroups) {
      for (final item in g.items) {
        if (item.contentId == null) continue;
        final resolved = resolveContentId(item.contentId!);
        expect(
          getById(resolved),
          isNotNull,
          reason: '${item.contentId} -> $resolved',
        );
      }
    }
  });

  test('calculators have units and formulas', () {
    expect(calculatorCatalog.length, 14);
    for (final c in calculatorCatalog) {
      expect(c.formula.trim(), isNotEmpty);
      expect(c.fields, isNotEmpty);
      for (final f in c.fields) {
        expect(f.unit.trim(), isNotEmpty);
      }
    }
  });

  test('runCalculator net worth', () {
    final r = runCalculator('calc-net-worth', {
      'assets': 100.0,
      'liabilities': 40.0,
    });
    expect(r, isNotNull);
    expect(r!.summary.contains('60'), isTrue);
  });

  test('scenarios and prompts and terms populated', () {
    expect(financialScenarios.length, greaterThanOrEqualTo(10));
    expect(promptItems.length, greaterThanOrEqualTo(15));
    expect(financialTerms.length, greaterThanOrEqualTo(40));
  });

  test('search finds basics', () {
    final r = search('복리');
    expect(r, isNotEmpty);
  });
}
