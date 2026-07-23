import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_constants.dart';
import '../data/calculator_catalog.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/disclaimer_banner.dart';

class ToolsListScreen extends StatelessWidget {
  const ToolsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '계산도구'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '교육용 계산기',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const DisclaimerBanner(compact: true),
        const SizedBox(height: 8),
        Text(AppConstants.calculatorDisclaimer),
        const SizedBox(height: 4),
        Text(
          AppConstants.noServerStorageNotice,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 20),
        ...calculatorCatalog.map(
          (c) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              minVerticalPadding: 14,
              title: Text(
                c.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('${c.purpose}\n공식: ${c.formula}'),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(c.route),
            ),
          ),
        ),
      ],
    );
  }
}
