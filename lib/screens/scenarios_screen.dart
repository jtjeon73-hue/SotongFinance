import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/scenario_data.dart';
import '../models/enums.dart';
import '../widgets/breadcrumb.dart';

class ScenariosScreen extends StatelessWidget {
  const ScenariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '금융 시나리오'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '교육용 금융 시나리오',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text('가상 사례입니다. 특정 개인 조언·수익 보장이 아닙니다.'),
        const SizedBox(height: 16),
        ...financialScenarios.map(
          (s) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              minVerticalPadding: 14,
              title: Text(
                s.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('${s.lifeStage.label}\n${s.situation}'),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/scenarios/${s.id}'),
            ),
          ),
        ),
      ],
    );
  }
}
