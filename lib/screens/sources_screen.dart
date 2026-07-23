import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/utils/freshness.dart';
import '../data/source_data.dart';
import '../models/enums.dart';
import '../models/official_source.dart';
import '../widgets/breadcrumb.dart';

class SourcesScreen extends StatefulWidget {
  const SourcesScreen({super.key});

  @override
  State<SourcesScreen> createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  String _filter = 'all';

  List<OfficialSource> get _filtered {
    final now = DateTime.now();
    return officialSources.where((s) {
      final label = freshnessFor(
        reviewDueAt: s.reviewDueAt,
        verificationStatusName: s.verificationStatus.name,
      );
      switch (_filter) {
        case 'overdue':
          final due = DateTime.tryParse(s.reviewDueAt);
          return due != null && now.isAfter(due);
        case 'needsReview':
          return label == FreshnessLabel.needsReview ||
              s.verificationStatus == VerificationStatus.needsReview;
        case 'officialCalc':
          return s.verificationStatus ==
              VerificationStatus.officialCalculatorRecommended;
        case 'professional':
          return s.verificationStatus ==
              VerificationStatus.professionalReviewRequired;
        case 'version':
          return s.verificationStatus == VerificationStatus.versionDependent;
        default:
          return true;
      }
    }).toList();
  }

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
        const Text(
          '아래 링크는 새 탭에서 열립니다. 최신 정보는 각 기관 공식 사이트에서 확인하세요. '
          '검색 결과 제목만으로 verified 처리하지 않습니다.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final e in const [
              ('all', '전체'),
              ('overdue', '검토기한 초과'),
              ('needsReview', '재확인 필요'),
              ('officialCalc', '공식 계산기'),
              ('professional', '전문가 검토'),
              ('version', '제도의존'),
            ])
              FilterChip(
                label: Text(e.$2),
                selected: _filter == e.$1,
                onSelected: (_) => setState(() => _filter = e.$1),
              ),
          ],
        ),
        const SizedBox(height: 16),
        ..._filtered.map((s) {
          final label = freshnessFor(
            reviewDueAt: s.reviewDueAt,
            verificationStatusName: s.verificationStatus.name,
          );
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              minVerticalPadding: 14,
              leading: const Icon(Icons.open_in_new),
              title: Text(
                s.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '${s.organization}\n${s.supports}\n'
                '확인: ${s.checkedAt} · 재검토: ${s.reviewDueAt} · '
                '${s.verificationStatus.label} · ${label.label}',
              ),
              isThreeLine: true,
              onTap: () async {
                final uri = Uri.parse(s.url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
          );
        }),
      ],
    );
  }
}
