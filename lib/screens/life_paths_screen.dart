import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/life_path_data.dart';
import '../data/source_data.dart';
import '../widgets/breadcrumb.dart';

class LifePathsScreen extends StatelessWidget {
  const LifePathsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '생애주기 학습 경로'),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '생애주기 학습 경로',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text('모든 사람에게 같은 순서를 강제하지 않습니다. 부양·건강·소득안정성·부채에 따라 달라질 수 있습니다.'),
        const SizedBox(height: 16),
        ...lifePaths.map((p) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text(
                p.title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(p.summary),
              children: [
                for (final step in p.steps)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        const Text('먼저 볼 콘텐츠'),
                        Wrap(
                          spacing: 8,
                          children: [
                            for (final id in step.contentIds)
                              ActionChip(
                                label: Text(id),
                                onPressed: () => context.go('/learn/$id'),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('점검할 숫자: ${step.numbersToCheck.join(', ')}'),
                        Text('할 일: ${step.actions.join(' · ')}'),
                        Text('피해야 할 실수: ${step.mistakes.join(' · ')}'),
                        if (step.calculatorRoutes.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          const Text('계산기·진단'),
                          Wrap(
                            spacing: 8,
                            children: [
                              for (final r in step.calculatorRoutes)
                                OutlinedButton(
                                  onPressed: () => context.go(r),
                                  child: Text(r),
                                ),
                            ],
                          ),
                        ],
                        if (step.officialSourceIds.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          const Text('공식자료'),
                          Wrap(
                            spacing: 8,
                            children: [
                              for (final sid in step.officialSourceIds)
                                Builder(
                                  builder: (context) {
                                    final src = officialSources
                                        .where((s) => s.id == sid)
                                        .firstOrNull;
                                    return Text(
                                      src == null
                                          ? sid
                                          : '${src.organization}: ${src.title}',
                                    );
                                  },
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
