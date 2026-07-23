import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BreadcrumbItem {
  const BreadcrumbItem({required this.label, this.route});

  final String label;
  final String? route;
}

class Breadcrumb extends StatelessWidget {
  const Breadcrumb({super.key, required this.items});

  final List<BreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Semantics(
      label: '경로: ${items.map((e) => e.label).join(', ')}',
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 4,
        runSpacing: 4,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0)
              Icon(Icons.chevron_right, size: 18, color: Colors.grey.shade600),
            _Crumb(item: items[i], isLast: i == items.length - 1),
          ],
        ],
      ),
    );
  }
}

class _Crumb extends StatelessWidget {
  const _Crumb({required this.item, required this.isLast});

  final BreadcrumbItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: isLast ? Theme.of(context).colorScheme.primary : null,
      fontWeight: isLast ? FontWeight.w600 : FontWeight.normal,
    );

    if (item.route != null && !isLast) {
      return Semantics(
        button: true,
        label: '${item.label}으로 이동',
        child: TextButton(
          onPressed: () => context.go(item.route!),
          style: TextButton.styleFrom(
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(item.label, style: style),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Text(item.label, style: style),
    );
  }
}
