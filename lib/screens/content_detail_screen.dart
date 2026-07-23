import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/theme/app_theme.dart';
import '../data/content_catalog.dart';
import '../data/content_id_mapping.dart';
import '../data/nav_data.dart';
import '../data/source_data.dart';
import '../models/enums.dart';
import '../models/finance_content.dart';
import '../models/nav_models.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/content_type_chip.dart';
import '../widgets/copy_button.dart';
import '../widgets/disclaimer_banner.dart';
import '../widgets/section_card.dart';

class ContentDetailScreen extends StatelessWidget {
  const ContentDetailScreen({super.key, required this.contentId});

  final String contentId;

  @override
  Widget build(BuildContext context) {
    final content = getById(contentId);
    if (content == null) {
      return _NotFound(id: contentId);
    }

    final siblings = _siblingsInCategory(content);
    final idx = siblings.indexWhere((c) => c.id == content.id);
    final prev = idx > 0 ? siblings[idx - 1] : null;
    final next = idx >= 0 && idx < siblings.length - 1
        ? siblings[idx + 1]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumb(items: _breadcrumbs(content)),
        const SizedBox(height: 16),
        Text(
          content.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 8),
        Text(content.summary, style: const TextStyle(height: 1.55)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ContentTypeChip(type: content.contentType),
            Chip(label: Text(content.difficulty.label)),
            Chip(label: Text('기준연도 ${content.referenceYear}')),
            Chip(label: Text('확인 ${content.checkedAt}')),
            Chip(label: Text(content.verificationStatus.label)),
          ],
        ),
        if (content.needsReview ||
            content.verificationStatus == VerificationStatus.needsReview) ...[
          const SizedBox(height: 12),
          _ReviewWarning(content: content),
        ],
        const SizedBox(height: 20),
        const DisclaimerBanner(compact: true),
        const SizedBox(height: 20),
        ...content.sections.map(
          (s) => SectionCard(
            heading: s.heading,
            body: s.body,
            bullets: s.bullets,
            type: s.type,
          ),
        ),
        if (content.checklist.isNotEmpty) ...[
          _ListSection(
            title: '체크리스트',
            items: content.checklist,
            copyLabel: '체크리스트 복사',
          ),
        ],
        if (content.nextActions.isNotEmpty)
          _ListSection(
            title: '다음 행동',
            items: content.nextActions,
            copyLabel: '다음 행동 복사',
          ),
        if (content.commonMistakes.isNotEmpty)
          _ListSection(
            title: '자주 하는 실수',
            items: content.commonMistakes,
            copyLabel: '실수 목록 복사',
          ),
        if (content.relatedIds.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('관련 학습', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...content.relatedIds.map((rid) {
            final related = getById(rid);
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(related?.title ?? rid),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/learn/$rid'),
            );
          }),
        ],
        if (content.sourceIds.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('공식 출처', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...content.sourceIds.map((sid) {
            final src = officialSources.where((s) => s.id == sid).firstOrNull;
            if (src == null) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(sid),
              );
            }
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.open_in_new, color: AppColors.official),
              title: Text(src.title),
              subtitle: Text(src.organization),
              onTap: () => _openUrl(src.url),
            );
          }),
        ],
        const SizedBox(height: 16),
        Row(
          children: [
            if (prev != null)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      context.go('/learn/${_navIdForContent(prev)}'),
                  icon: const Icon(Icons.arrow_back),
                  label: Text(
                    '이전: ${prev.title}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            if (prev != null && next != null) const SizedBox(width: 12),
            if (next != null)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      context.go('/learn/${_navIdForContent(next)}'),
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(
                    '다음: ${next.title}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  List<BreadcrumbItem> _breadcrumbs(FinanceContent content) {
    NavGroup? group;
    for (final g in appNavGroups) {
      if (g.items.any(
        (i) => i.contentId == contentId || i.contentId == content.id,
      )) {
        group = g;
        break;
      }
    }
    return [
      const BreadcrumbItem(label: '홈', route: '/'),
      if (group != null) BreadcrumbItem(label: group.title),
      BreadcrumbItem(label: content.title),
    ];
  }

  List<FinanceContent> _siblingsInCategory(FinanceContent content) {
    return allFinanceContent
        .where((c) => c.category == content.category)
        .toList();
  }

  String _navIdForContent(FinanceContent c) {
    for (final entry in navContentIdMap.entries) {
      if (entry.value == c.id) return entry.key;
    }
    return c.id;
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _NotFound extends StatelessWidget {
  const _NotFound({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '콘텐츠 없음'),
          ],
        ),
        const SizedBox(height: 24),
        Text('콘텐츠를 찾을 수 없습니다: $id'),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => context.go('/search'),
          child: const Text('검색으로 이동'),
        ),
      ],
    );
  }
}

class _ReviewWarning extends StatelessWidget {
  const _ReviewWarning({required this.content});

  final FinanceContent content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber, color: AppColors.warning),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '검토 필요: reviewDueAt ${content.reviewDueAt}. '
              '최신 공식 자료와 대조하세요.',
            ),
          ),
        ],
      ),
    );
  }
}

class _ListSection extends StatelessWidget {
  const _ListSection({
    required this.title,
    required this.items,
    required this.copyLabel,
  });

  final String title;
  final List<String> items;
  final String copyLabel;

  @override
  Widget build(BuildContext context) {
    final text = items.map((e) => '• $e').join('\n');
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                CopyTextButton(text: text, label: copyLabel),
              ],
            ),
            const SizedBox(height: 8),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('☐ '),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final it = iterator;
    return it.moveNext() ? it.current : null;
  }
}
