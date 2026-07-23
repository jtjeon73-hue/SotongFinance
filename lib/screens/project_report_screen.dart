import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../data/calculator_catalog.dart';
import '../data/content_catalog.dart';
import '../data/content_quality_data.dart';
import '../data/life_path_data.dart';
import '../data/phase2_upgraded_ids.dart';
import '../data/prompt_data.dart';
import '../data/scenario_data.dart';
import '../data/source_data.dart';
import '../data/term_data.dart';
import '../models/content_quality.dart';
import '../models/enums.dart';
import '../models/project_report.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/copy_button.dart';

class ProjectReportScreen extends StatelessWidget {
  const ProjectReportScreen({super.key});

  ProjectReport _buildReport() {
    final grades = countByGrade();
    final overdueSources = officialSources.where((s) {
      final due = DateTime.tryParse(s.reviewDueAt);
      return due != null && DateTime.now().isAfter(due);
    }).length;
    final statusCounts = <VerificationStatus, int>{
      for (final s in VerificationStatus.values) s: 0,
    };
    for (final s in officialSources) {
      statusCounts[s.verificationStatus] =
          (statusCounts[s.verificationStatus] ?? 0) + 1;
    }

    return ProjectReport(
      phase: AppConstants.phase,
      summary:
          '2단계 실무 콘텐츠 심화: 핵심 ${phase2UpgradedIds.length}개 수동 보강, '
          '교육용 재무진단·생애주기 경로·계산기 확장·검토기한·출처 확대. '
          '상품 추천·세율 임의고정·개인재무 서버저장 없음.',
      contentCount: allFinanceContent.length,
      calculatorCount: calculatorCatalog.length,
      scenarioCount: financialScenarios.length,
      termCount: financialTerms.length,
      promptCount: promptItems.length,
      sourceCount: officialSources.length,
      testStatus:
          'format / analyze --fatal-infos / flutter test / web release / 반응형 E2E',
      commitHash: '6aef3cf6ce1a397acd079dd25684649c6fece4ce',
      actionsStatus: 'push 후 build-and-test · Firebase Hosting 자동배포 확인',
      firebaseProjectId: AppConstants.firebaseProjectId,
      hostingUrl: AppConstants.hostingUrl,
      qualitySummary:
          '전체 ${allFinanceContent.length} · '
          'A ${grades[ContentQualityGrade.a] ?? 0} · '
          'B ${grades[ContentQualityGrade.b] ?? 0} · '
          'C ${grades[ContentQualityGrade.c] ?? 0} · '
          'D ${grades[ContentQualityGrade.d] ?? 0} '
          '(글자수 비사용). 출처 상태 verified ${statusCounts[VerificationStatus.verified]} · '
          'versionDependent ${statusCounts[VerificationStatus.versionDependent]} · '
          'needsReview ${statusCounts[VerificationStatus.needsReview]} · '
          'officialCalculatorRecommended ${statusCounts[VerificationStatus.officialCalculatorRecommended]} · '
          'professionalReviewRequired ${statusCounts[VerificationStatus.professionalReviewRequired]} · '
          'educationalExample ${statusCounts[VerificationStatus.educationalExample]} · '
          '출처 검토기한 초과 $overdueSources',
      upgradedContentCount: phase2UpgradedIds.length,
      lifePathCount: lifePaths.length,
      diagnosisAvailable: true,
      remainingReviews: [
        '세금·연금·대출규제 versionDependent 콘텐츠 공식 재대조',
        '잔여 C/D 템플릿 콘텐츠 3단계 보강',
        '전문가 검토 필요 표시 항목(농지·상속·세무) 심화',
      ],
      phase2Plan: [
        '핵심 콘텐츠 수동 보강 완료(${phase2UpgradedIds.length})',
        '재무진단·생애주기·계산기·프롬프트·출처·검토기한 반영',
        '남은 C/D는 자동 A 처리하지 않음',
      ],
      phase3Plan: [
        '자산배분·은퇴 인출 심화',
        '세금·상속 준비 심화(확정세액 아님)',
        '위험관리·스트레스 시나리오 확장',
        '전문가 검토 연계·제도 변경 타임라인',
      ],
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
            BreadcrumbItem(label: '2단계 완료 보고'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '2단계 완료 보고',
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
          '참고: 커밋 해시는 push 후 갱신합니다. '
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
