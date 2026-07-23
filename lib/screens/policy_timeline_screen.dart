import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/policy_timeline_data.dart';
import '../data/source_data.dart';
import '../widgets/breadcrumb.dart';

class PolicyTimelineScreen extends StatelessWidget {
  const PolicyTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '제도 타임라인'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '제도 변경 타임라인(교육용)',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          '확정되지 않은 법안은 시행으로 표시하지 않습니다. '
          '세부 수치는 공식자료를 재확인하세요.',
        ),
        const SizedBox(height: 16),
        ...policyTimeline.map((t) {
          final src = officialSources
              .where((s) => s.id == t.sourceId)
              .firstOrNull;
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text('${t.area} · ${t.name}'),
              subtitle: Text(
                '상태: ${t.status}\n${t.note}\n재확인: ${t.reviewDueAt}'
                '${src != null ? '\n출처: ${src.title}' : ''}',
              ),
              isThreeLine: true,
              onTap: src == null ? null : () => context.go('/sources'),
            ),
          );
        }),
      ],
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final it = iterator;
    return it.moveNext() ? it.current : null;
  }
}
