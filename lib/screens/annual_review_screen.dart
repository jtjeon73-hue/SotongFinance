import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../data/annual_review_data.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/copy_button.dart';

class AnnualReviewScreen extends StatefulWidget {
  const AnnualReviewScreen({super.key});

  @override
  State<AnnualReviewScreen> createState() => _AnnualReviewScreenState();
}

class _AnnualReviewScreenState extends State<AnnualReviewScreen> {
  final _checked = <String>{};
  final _notes = TextEditingController();

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final md = annualReviewMarkdown(_checked, notes: _notes.text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '연간 점검'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '연간 금융점검표',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(AppConstants.noServerStorageNotice),
        const SizedBox(height: 12),
        CopyTextButton(text: md, label: '연간 점검표 복사'),
        const SizedBox(height: 12),
        ...annualReviewItems.map(
          (item) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(item),
            value: _checked.contains(item),
            onChanged: (v) {
              setState(() {
                if (v == true) {
                  _checked.add(item);
                } else {
                  _checked.remove(item);
                }
              });
            },
          ),
        ),
        TextField(
          controller: _notes,
          decoration: const InputDecoration(labelText: '메모(선택)'),
          maxLines: 3,
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }
}
