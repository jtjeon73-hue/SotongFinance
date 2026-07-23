import 'package:flutter/material.dart';

import '../data/scenario_data.dart';
import '../models/enums.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/copy_button.dart';
import '../widgets/disclaimer_banner.dart';

class ScenarioDetailScreen extends StatelessWidget {
  const ScenarioDetailScreen({super.key, required this.scenarioId});

  final String scenarioId;

  @override
  Widget build(BuildContext context) {
    final scenario = financialScenarios
        .where((s) => s.id == scenarioId)
        .firstOrNull;
    if (scenario == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Breadcrumb(
            items: [
              BreadcrumbItem(label: '홈', route: '/'),
              BreadcrumbItem(label: '시나리오', route: '/scenarios'),
              BreadcrumbItem(label: '없음'),
            ],
          ),
          const SizedBox(height: 24),
          Text('시나리오를 찾을 수 없습니다: $scenarioId'),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumb(
          items: [
            const BreadcrumbItem(label: '홈', route: '/'),
            const BreadcrumbItem(label: '시나리오', route: '/scenarios'),
            BreadcrumbItem(label: scenario.title),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          scenario.title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        Chip(label: Text(scenario.lifeStage.label)),
        const SizedBox(height: 8),
        CopyTextButton(
          text: scenario.toMarkdown(),
          label: '사례 Markdown 복사',
          successMessage: '사례를 복사했습니다',
        ),
        const SizedBox(height: 12),
        const DisclaimerBanner(compact: true),
        const SizedBox(height: 12),
        Text(scenario.disclaimer),
        const SizedBox(height: 20),
        _Block('현재상황', scenario.situation),
        _Block('목표', scenario.goals.join('\n• '), bullets: true),
        _Block('현금흐름', scenario.cashflow),
        _Block('소득', scenario.income),
        _Block('지출', scenario.expenses),
        _Block('자산', scenario.assets),
        _Block('부채', scenario.liabilities),
        _Block('보험', scenario.insurance),
        _Block('연금', scenario.pension),
        _Block('부동산', scenario.realEstate),
        _Block('세금', scenario.taxNotes),
        _Block('위험', scenario.risks.join('\n• '), bullets: true),
        _Block('대안(트레이드오프)', scenario.alternatives.join('\n• '), bullets: true),
        _Block('스트레스 테스트', scenario.stressTests.join('\n• '), bullets: true),
        _Block('우선순위', scenario.priorities.join('\n• '), bullets: true),
        _Block('실행순서', scenario.actionOrder.join('\n• '), bullets: true),
        _Block('점검주기', scenario.reviewCycle),
        _Block('변경조건', scenario.changeConditions.join('\n• '), bullets: true),
        _Block('비상 시나리오', scenario.contingency.join('\n• '), bullets: true),
      ],
    );
  }
}

class _Block extends StatelessWidget {
  const _Block(this.title, this.body, {this.bullets = false});

  final String title;
  final String body;
  final bool bullets;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(bullets ? '• $body' : body),
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
