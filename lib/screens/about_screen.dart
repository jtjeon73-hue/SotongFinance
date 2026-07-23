import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../widgets/breadcrumb.dart';
import '../widgets/disclaimer_banner.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Breadcrumb(
          items: [
            BreadcrumbItem(label: '홈', route: '/'),
            BreadcrumbItem(label: '사이트 안내'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'SotongFinance 안내',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 16),
        const DisclaimerBanner(),
        const SizedBox(height: 20),
        _InfoCard(
          title: '목적',
          body:
              '${AppConstants.appName}는 금융·자산관리 학습을 위한 교육용 웹사이트입니다. '
              '특정 상품 추천, 매수·매도 지시, 수익 보장을 제공하지 않습니다.',
        ),
        _InfoCard(
          title: '1단계 범위',
          body:
              '정적 학습 콘텐츠, 교육용 계산기, 용어·시나리오·프롬프트, 공식 출처 링크. '
              '계산기 입력값은 브라우저에만 머물며 서버에 저장하지 않습니다.',
        ),
        _InfoCard(
          title: '색·디자인',
          body:
              '딥 네이비·청록·골드 포인트의 밝은 전문 테마. '
              '수익 보장·빠른 부자 등 과장 이미지를 사용하지 않습니다.',
        ),
        _InfoCard(
          title: '확인 권장',
          body:
              '세금·연금·대출·보험·부동산 등은 개인 상황과 기준일에 따라 달라집니다. '
              '실제 의사결정 전 공식기관과 전문가에게 확인하세요.',
        ),
        _InfoCard(
          title: '연락·배포',
          body:
              'Firebase 프로젝트 ID: ${AppConstants.firebaseProjectId}\n'
              '호스팅 URL(예정): ${AppConstants.hostingUrl}\n'
              '현재 ${AppConstants.phase} 개발 중입니다.',
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(body, style: const TextStyle(height: 1.55)),
          ],
        ),
      ),
    );
  }
}
