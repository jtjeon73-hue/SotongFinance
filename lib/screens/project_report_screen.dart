import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../data/calculator_catalog.dart';
import '../data/content_catalog.dart';
import '../data/prompt_data.dart';
import '../data/scenario_data.dart';
import '../data/source_data.dart';
import '../data/term_data.dart';
import '../models/project_report.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/copy_button.dart';

class ProjectReportScreen extends StatelessWidget {
  const ProjectReportScreen({super.key});

  ProjectReport _buildReport() {
    return ProjectReport(
      phase: AppConstants.phase,
      summary:
          'Flutter Web 기반 SotongFinance 1단계: 학습 콘텐츠·계산기·용어·시나리오·프롬프트·'
          '공식 출처 UI 및 라우팅 구현. 교육용 면책·접근성(48px 터치) 반영.',
      contentCount: allFinanceContent.length,
      calculatorCount: calculatorCatalog.length,
      scenarioCount: financialScenarios.length,
      termCount: financialTerms.length,
      promptCount: promptItems.length,
      sourceCount: officialSources.length,
      testStatus: 'flutter analyze 통과 / flutter test 32 passed (로컬)',
      commitHash: '4a686738052117f5fc266ccf44a916045d91cea9',
      actionsStatus: 'workflow 구성 완료 · Secret 등록·Actions 실행은 배포 후 확인',
      firebaseProjectId: AppConstants.firebaseProjectId,
      hostingUrl: AppConstants.hostingUrl,
      remainingReviews: [
        '세법·연금·부동산 versionDependent 콘텐츠 공식 대조',
        'needsReview 표시 항목 갱신',
        'GitHub Secret FIREBASE_SERVICE_ACCOUNT_SOTONG_FINANCE 등록 확인',
      ],
      phase2Plan: ['실무 난이도 콘텐츠 확장', '출처 reviewDueAt 만료 알림', '생애주기별 학습 경로 큐레이션'],
      phase3Plan: ['전문가 심화·제도 변경 타임라인', '별도 보안 검토 후 선택적 개인 재무기록', '접근성·다국어 검토'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final report = _buildReport();
    final markdown = report.toMarkdown();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '1단계 완료 보고'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '1단계 완료 보고',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            CopyTextButton(
              text: markdown,
              label: '전체 보고 복사',
              successMessage: '보고서를 복사했습니다',
            ),
            CopyTextButton(text: AppConstants.hostingUrl, label: '운영 주소 복사'),
            CopyTextButton(text: report.commitHash, label: '커밋 해시 복사'),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          '참고: 커밋 해시는 push 후 /project/report 또는 Git에서 확인하세요. '
          '서버에 개인 재무정보를 저장하지 않습니다.',
          style: TextStyle(fontSize: 13),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SelectableText(
              markdown,
              style: const TextStyle(fontFamily: 'monospace', height: 1.45),
            ),
          ),
        ),
      ],
    );
  }
}
