import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../data/ips_data.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/copy_button.dart';
import '../widgets/disclaimer_banner.dart';

class IpsScreen extends StatefulWidget {
  const IpsScreen({super.key});

  @override
  State<IpsScreen> createState() => _IpsScreenState();
}

class _IpsScreenState extends State<IpsScreen> {
  final _controllers = {
    for (final f in ipsTemplateFields) f.id: TextEditingController(),
  };

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Map<String, String> get _values => {
    for (final e in _controllers.entries) e.key: e.value.text,
  };

  @override
  Widget build(BuildContext context) {
    final md = buildIpsMarkdown(_values);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '투자정책서'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '교육용 투자정책서(IPS)',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(ipsDisclaimer, style: const TextStyle(height: 1.45)),
        const SizedBox(height: 12),
        const DisclaimerBanner(compact: true),
        const SizedBox(height: 8),
        Text(AppConstants.noServerStorageNotice),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            CopyTextButton(
              text: md,
              label: 'IPS Markdown 복사',
              successMessage: '투자정책서를 복사했습니다',
            ),
            OutlinedButton(
              onPressed: () {
                for (final c in _controllers.values) {
                  c.clear();
                }
                setState(() {});
              },
              child: const Text('초기화'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...ipsTemplateFields.map(
          (f) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextField(
              controller: _controllers[f.id],
              decoration: InputDecoration(labelText: f.label, hintText: f.hint),
              maxLines: 2,
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),
      ],
    );
  }
}
