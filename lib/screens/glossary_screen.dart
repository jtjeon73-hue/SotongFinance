import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/term_data.dart';
import '../models/enums.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/highlight_text.dart';

class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({super.key});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final q = _query.trim().toLowerCase();
    final terms = financialTerms.where((t) {
      if (q.isEmpty) return true;
      return t.term.toLowerCase().contains(q) ||
          t.definition.toLowerCase().contains(q) ||
          t.category.toLowerCase().contains(q);
    }).toList()..sort((a, b) => a.term.compareTo(b.term));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '금융용어'),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            labelText: '용어 검색',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (v) => setState(() => _query = v),
        ),
        const SizedBox(height: 16),
        Text('${terms.length}개 용어'),
        const SizedBox(height: 8),
        ...terms.map(
          (t) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ExpansionTile(
              title: HighlightText(
                text: t.term,
                query: _query,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('${t.category} · ${t.difficulty.label}'),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HighlightText(text: t.definition, query: _query),
                      if (t.example != null) ...[
                        const SizedBox(height: 8),
                        Text('예: ${t.example}'),
                      ],
                      if (t.relatedIds.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: t.relatedIds
                              .map(
                                (id) => ActionChip(
                                  label: Text('학습: $id'),
                                  onPressed: () => context.go('/learn/$id'),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
