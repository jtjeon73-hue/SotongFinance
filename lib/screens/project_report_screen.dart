import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../data/application_validation_data.dart';
import '../data/calculator_catalog.dart';
import '../data/content_catalog.dart';
import '../data/content_quality_data.dart';
import '../data/crisis_data.dart';
import '../data/finance_plan_data.dart';
import '../data/ips_data.dart';
import '../data/life_path_data.dart';
import '../data/phase2_upgraded_ids.dart';
import '../data/phase3_upgraded_ids.dart';
import '../data/policy_timeline_data.dart';
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
    final cdKinds = countCdByKind();
    final appVal = countApplicationValidation();

    return ProjectReport(
      phase: AppConstants.phase,
      summary:
          '3단계 전문가 심화: Phase2 ${phase2UpgradedIds.length} + Phase3 ${phase3UpgradedIds.length}개 수동 보강, '
          'IPS·재무계획·위기대응·연간점검·제도타임라인·전문가 계산기·프롬프트 확장. '
          '상품 추천·세율 임의고정·개인재무 서버저장 없음.',
      contentCount: allFinanceContent.length,
      calculatorCount: calculatorCatalog.length,
      scenarioCount: financialScenarios.length,
      termCount: financialTerms.length,
      promptCount: promptItems.length,
      sourceCount: officialSources.length,
      testStatus:
          'format / analyze --fatal-infos / flutter test / web release / 반응형 E2E',
      commitHash: '4aea013744ce7562b8b067e41cda0aceec4c8484',
      actionsStatus: 'push 후 build-and-test · Firebase Hosting 자동배포 확인',
      firebaseProjectId: AppConstants.firebaseProjectId,
      hostingUrl: AppConstants.hostingUrl,
      qualitySummary:
          '전체 ${allFinanceContent.length} · '
          'A ${grades[ContentQualityGrade.a] ?? 0} · '
          'B ${grades[ContentQualityGrade.b] ?? 0} · '
          'C ${grades[ContentQualityGrade.c] ?? 0} · '
          'D ${grades[ContentQualityGrade.d] ?? 0} '
          '(유형별 판정, 글자수 비사용). '
          '잔여 C/D 유형: ${cdKinds.entries.where((e) => e.value > 0).map((e) => '${e.key.label}:${e.value}').join(', ')}. '
          '출처 verified ${statusCounts[VerificationStatus.verified]} · '
          'versionDependent ${statusCounts[VerificationStatus.versionDependent]} · '
          'needsReview ${statusCounts[VerificationStatus.needsReview]} · '
          'officialCalculatorRecommended ${statusCounts[VerificationStatus.officialCalculatorRecommended]} · '
          'professionalReviewRequired ${statusCounts[VerificationStatus.professionalReviewRequired]} · '
          'educationalExample ${statusCounts[VerificationStatus.educationalExample]} · '
          '출처 검토기한 초과 $overdueSources · '
          'IPS ${ipsTemplateFields.length}항목 · 재무계획 ${financePlanSteps.length}단계 · '
          '위기대응 ${crisisEvents.length} · 타임라인 ${policyTimeline.length} · '
          '적용검증 deskReviewed ${appVal[ApplicationValidationStatus.deskReviewed]} · '
          'calculationValidated ${appVal[ApplicationValidationStatus.calculationValidated]} · '
          'officialCalculatorRequired ${appVal[ApplicationValidationStatus.officialCalculatorRequired]} · '
          'professionalReviewRequired ${appVal[ApplicationValidationStatus.professionalReviewRequired]} · '
          'userSituationRequired ${appVal[ApplicationValidationStatus.userSituationRequired]} · '
          'notApplicable ${appVal[ApplicationValidationStatus.notApplicable]}',
      upgradedContentCount: phase2UpgradedIds.length + phase3UpgradedIds.length,
      lifePathCount: lifePaths.length,
      diagnosisAvailable: true,
      remainingReviews: [
        '세금·연금·대출규제 versionDependent 공식 재대조',
        '잔여 C/D(역할상 개념·용어)는 억지 A 미적용',
        '상속·농지·세무는 professionalReviewRequired 유지',
        '개인 상황 적용은 userSituationRequired',
      ],
      phase2Plan: [
        '2단계 보강 ${phase2UpgradedIds.length} 완료',
        '재무진단·생애주기·검토기한 유지',
      ],
      phase3Plan: [
        '3단계 보강 ${phase3UpgradedIds.length} 완료',
        'IPS·재무계획·위기대응·연간점검·타임라인',
        '전문가 계산기·프롬프트·유형별 품질판정',
        '개인정보 비저장·교육용 제한 유지',
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
            BreadcrumbItem(label: '3단계 완료 보고'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '3단계 완료 보고',
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
