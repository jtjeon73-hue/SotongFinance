import 'package:flutter/material.dart';

import '../data/crisis_data.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/copy_button.dart';

class CrisisScreen extends StatelessWidget {
  const CrisisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '위기대응'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '금융 위기대응 계획',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text('미검증 전화번호는 작성하지 않습니다. 최신 공식 신고·지원 안내를 확인하세요.'),
        const SizedBox(height: 16),
        ...crisisEvents.map(
          (e) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ExpansionTile(
              title: Text(e.title),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                CopyTextButton(text: crisisMarkdown(e), label: '위기대응 계획 복사'),
                const SizedBox(height: 8),
                Text(crisisMarkdown(e), style: const TextStyle(height: 1.4)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
