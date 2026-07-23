import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/content_catalog.dart';
import '../models/enums.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/content_type_chip.dart';
import '../widgets/highlight_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _queryController = TextEditingController();
  String? _category;
  Difficulty? _difficulty;
  ContentType? _contentType;
  LifeStage? _lifeStage;
  bool _reviewDueOnly = false;
  bool _professionalOnly = false;
  bool _easyFinanceOnly = false;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  List<dynamic> get _results {
    var list = search(_queryController.text);
    if (_category != null) {
      list = list.where((c) => c.category == _category).toList();
    }
    if (_difficulty != null) {
      list = list.where((c) => c.difficulty == _difficulty).toList();
    }
    if (_contentType != null) {
      list = list.where((c) => c.contentType == _contentType).toList();
    }
    if (_lifeStage != null) {
      list = list.where((c) => c.lifeStages.contains(_lifeStage)).toList();
    }
    if (_reviewDueOnly) {
      list = list.where((c) => c.needsReview == true).toList();
    }
    if (_professionalOnly) {
      list = list
          .where(
            (c) =>
                c.contentType == ContentType.professionalReview ||
                c.verificationStatus ==
                    VerificationStatus.professionalReviewRequired,
          )
          .toList();
    }
    if (_easyFinanceOnly) {
      list = list
          .where(
            (c) =>
                c.difficulty == Difficulty.intro ||
                c.difficulty == Difficulty.basic ||
                c.lifeStages.contains(LifeStage.retired),
          )
          .toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final query = _queryController.text;
    final results = _results;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '검색'),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _queryController,
          decoration: const InputDecoration(
            labelText: '검색어',
            prefixIcon: Icon(Icons.search),
            hintText: '제목, 요약, 키워드…',
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _FilterChip<Difficulty>(
              label: '난이도',
              value: _difficulty,
              items: Difficulty.values,
              itemLabel: (d) => d.label,
              onChanged: (v) => setState(() => _difficulty = v),
            ),
            _FilterChip<ContentType>(
              label: '유형',
              value: _contentType,
              items: ContentType.values,
              itemLabel: (t) => t.label,
              onChanged: (v) => setState(() => _contentType = v),
            ),
            _FilterChip<LifeStage>(
              label: '인생단계',
              value: _lifeStage,
              items: LifeStage.values,
              itemLabel: (s) => s.label,
              onChanged: (v) => setState(() => _lifeStage = v),
            ),
            DropdownMenu<String?>(
              label: const Text('카테고리'),
              width: 200,
              initialSelection: _category,
              dropdownMenuEntries: [
                const DropdownMenuEntry<String?>(value: null, label: '전체'),
                ...allCategories.map(
                  (c) => DropdownMenuEntry<String?>(value: c, label: c),
                ),
              ],
              onSelected: (v) => setState(() => _category = v),
            ),
            FilterChip(
              label: const Text('검토기한 초과'),
              selected: _reviewDueOnly,
              onSelected: (v) => setState(() => _reviewDueOnly = v),
            ),
            FilterChip(
              label: const Text('전문가 확인 필요'),
              selected: _professionalOnly,
              onSelected: (v) => setState(() => _professionalOnly = v),
            ),
            FilterChip(
              label: const Text('쉬운 금융'),
              selected: _easyFinanceOnly,
              onSelected: (v) => setState(() => _easyFinanceOnly = v),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('${results.length}건'),
        const SizedBox(height: 8),
        ...results.map(
          (c) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              minVerticalPadding: 12,
              title: HighlightText(
                text: c.title,
                query: query,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  HighlightText(text: c.summary, query: query),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    children: [
                      ContentTypeChip(type: c.contentType),
                      Chip(
                        label: Text(c.category),
                        visualDensity: VisualDensity.compact,
                      ),
                      if (c.needsReview)
                        const Chip(
                          label: Text('재확인 필요'),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                ],
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/learn/${c.id}'),
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip<T> extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T?>(
      tooltip: label,
      onSelected: onChanged,
      itemBuilder: (context) => [
        PopupMenuItem<T?>(value: null, child: Text('$label: 전체')),
        ...items.map(
          (e) => PopupMenuItem<T?>(value: e, child: Text(itemLabel(e))),
        ),
      ],
      child: Chip(
        label: Text(value == null ? label : '$label: ${itemLabel(value as T)}'),
        deleteIcon: value != null ? const Icon(Icons.close, size: 16) : null,
        onDeleted: value != null ? () => onChanged(null) : null,
      ),
    );
  }
}
