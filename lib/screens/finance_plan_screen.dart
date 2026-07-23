import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/finance_plan_data.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/copy_button.dart';

class FinancePlanScreen extends StatelessWidget {
  const FinancePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final md = StringBuffer()
      ..writeln('# 재무계획 16단계 (교육용)')
      ..writeln();
    for (final s in financePlanSteps) {
      md
        ..writeln('## ${s.order}. ${s.title}')
        ..writeln('- 완료기준: ${s.doneWhen}')
        ..writeln('- 재검토: ${s.reviewWhen}')
        ..writeln();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '재무계획'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '재무계획 전체 구조',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          '순서는 기본 안내이며 부양·건강·소득안정·부채에 따라 달라집니다. '
          '특정 상품을 추천하지 않습니다.',
        ),
        const SizedBox(height: 12),
        CopyTextButton(text: md.toString(), label: '전체 구조 복사'),
        const SizedBox(height: 16),
        ...financePlanSteps.map((s) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ExpansionTile(
              title: Text('${s.order}. ${s.title}'),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                _kv('자료', s.materials),
                _kv('숫자', s.numbers),
                _kv('결정', s.decisions),
                _kv('가족 논의', s.familyTalk),
                _kv('공식출처', s.sources),
                Text('완료: ${s.doneWhen}'),
                Text('재검토: ${s.reviewWhen}'),
                if (s.calculators.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: s.calculators
                        .map(
                          (r) => ActionChip(
                            label: Text(r),
                            onPressed: () => context.go(r),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _kv(String k, List<String> v) {
    if (v.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text('$k: ${v.join(', ')}'),
    );
  }
}
