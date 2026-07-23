import 'package:flutter/material.dart';

import '../data/prompt_data.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/copy_button.dart';

class PromptsScreen extends StatelessWidget {
  const PromptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '분석 프롬프트'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '재무 분석 프롬프트',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text('AI 도구에 붙여 넣을 교육용 프롬프트입니다. 민감정보는 제거하고 사용하세요.'),
        const SizedBox(height: 16),
        ...promptItems.map(
          (p) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          p.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      CopyTextButton(text: p.promptText, label: '프롬프트 복사'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(p.purpose),
                  const SizedBox(height: 8),
                  Text('필요 입력: ${p.requiredInputs.join(', ')}'),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      p.promptText,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('추측 금지: ${p.doNotGuess.join(', ')}'),
                  Text('공식 확인: ${p.officialChecks.join(', ')}'),
                  const SizedBox(height: 4),
                  Text(
                    p.privacyNote,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    p.interpretationLimit,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
