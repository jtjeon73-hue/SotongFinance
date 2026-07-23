import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/source_data.dart';
import '../models/enums.dart';
import '../widgets/breadcrumb.dart';

class SourcesScreen extends StatelessWidget {
  const SourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '공식자료'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '공식 출처',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text('아래 링크는 새 탭에서 열립니다. 최신 정보는 각 기관 공식 사이트에서 확인하세요.'),
        const SizedBox(height: 16),
        ...officialSources.map(
          (s) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              minVerticalPadding: 14,
              leading: const Icon(Icons.open_in_new),
              title: Text(
                s.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '${s.organization}\n${s.supports}\n확인: ${s.checkedAt} · ${s.verificationStatus.label}',
              ),
              isThreeLine: true,
              onTap: () async {
                final uri = Uri.parse(s.url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
