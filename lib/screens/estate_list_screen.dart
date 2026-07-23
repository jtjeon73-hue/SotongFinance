import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../data/annual_review_data.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/copy_button.dart';

class EstateListScreen extends StatefulWidget {
  const EstateListScreen({super.key});

  @override
  State<EstateListScreen> createState() => _EstateListScreenState();
}

class _EstateListScreenState extends State<EstateListScreen> {
  final _controllers = {
    for (final f in estateListFields) f: TextEditingController(),
  };

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final values = {for (final e in _controllers.entries) e.key: e.value.text};
    final md = estateListMarkdown(values);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '상속재산 목록'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '상속재산 목록 도구',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          '상속세 계산기가 아닙니다. 법률·세무 전문가 확인이 필요할 수 있습니다. '
          '비밀번호를 평문으로 적지 마세요.',
        ),
        const SizedBox(height: 8),
        Text(AppConstants.noServerStorageNotice),
        const SizedBox(height: 12),
        CopyTextButton(text: md, label: '상속재산 목록 복사'),
        const SizedBox(height: 12),
        ...estateListFields.map(
          (f) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: _controllers[f],
              decoration: InputDecoration(labelText: f),
              maxLines: 2,
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),
      ],
    );
  }
}
