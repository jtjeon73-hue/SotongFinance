import 'package:flutter/material.dart';

import '../models/enums.dart';
import 'content_type_chip.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.heading,
    required this.body,
    this.bullets = const [],
    this.type = ContentType.concept,
    this.trailing,
  });

  final String heading;
  final String body;
  final List<String> bullets;
  final ContentType type;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final borderColor = contentTypeColor(type);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: borderColor, width: 4)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    heading,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ContentTypeChip(type: type),
                ?trailing,
              ],
            ),
            const SizedBox(height: 10),
            Text(body, style: const TextStyle(height: 1.55)),
            if (bullets.isNotEmpty) ...[
              const SizedBox(height: 10),
              ...bullets.map(
                (b) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(child: Text(b)),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
