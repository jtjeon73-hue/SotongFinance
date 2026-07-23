import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../data/calculator_catalog.dart';
import '../data/nav_data.dart';
import '../data/source_data.dart';
import '../models/enums.dart';
import '../widgets/disclaimer_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroBanner(theme: theme),
        const SizedBox(height: 28),
        const DisclaimerBanner(),
        const SizedBox(height: 28),
        _SectionTitle('이 사이트의 목적'),
        const SizedBox(height: 8),
        Text(
          'SotongFinance는 금융·자산관리를 체계적으로 학습하기 위한 교육 플랫폼입니다. '
          '순자산·현금흐름·저축·투자·대출·세금·연금·사기 예방까지 생활 재무의 흐름을 '
          '개념→계산→공식 확인 순서로 정리합니다.',
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.55),
        ),
        const SizedBox(height: 28),
        _SectionTitle('돈의 흐름'),
        const SizedBox(height: 12),
        _MoneyFlowDiagram(),
        const SizedBox(height: 28),
        _SectionTitle('학습 영역'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: appNavGroups
              .where((g) => !['tools', 'refs', 'project'].contains(g.id))
              .map(
                (g) => _AreaChip(
                  label: g.title,
                  icon: g.icon,
                  onTap: g.items.isNotEmpty
                      ? () => context.go(g.items.first.route)
                      : null,
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 28),
        _SectionTitle('인생 단계별 시작점'),
        const SizedBox(height: 12),
        ..._lifeStageStarts.map(
          (e) => _LinkTile(title: e.$1.label, subtitle: e.$2, route: e.$3),
        ),
        const SizedBox(height: 28),
        _SectionTitle('노후·연금 바로가기'),
        const SizedBox(height: 12),
        _LinkTile(
          title: '노후 재무 흐름',
          subtitle: '국민연금·퇴직연금·생활비·부족액 점검',
          route: '/learn/pension-basics',
        ),
        _LinkTile(
          title: '은퇴자금 부족액 계산기',
          subtitle: '교육용 추정',
          route: '/tools/retirement-gap',
        ),
        const SizedBox(height: 28),
        _SectionTitle('금융사기 예방'),
        const SizedBox(height: 12),
        _LinkTile(
          title: '보이스피싱·투자 사기 경고',
          subtitle: '피해 예방과 공식 신고 경로',
          route: '/learn/fraud-voice',
        ),
        const SizedBox(height: 28),
        _SectionTitle('인기 계산기'),
        const SizedBox(height: 12),
        ...calculatorCatalog
            .take(6)
            .map(
              (c) => _LinkTile(
                title: c.title,
                subtitle: c.purpose,
                route: c.route,
              ),
            ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => context.go('/tools'),
            child: const Text('모든 계산기 보기'),
          ),
        ),
        const SizedBox(height: 28),
        _SectionTitle('공식 출처'),
        const SizedBox(height: 12),
        ...officialSources
            .take(6)
            .map((s) => _SourceMiniTile(name: s.title, org: s.organization)),
        TextButton(
          onPressed: () => context.go('/sources'),
          child: const Text('전체 공식자료 보기'),
        ),
      ],
    );
  }

  static const _lifeStageStarts = [
    (LifeStage.newGraduate, '예산·부채·비상자금', '/learn/money-budget'),
    (LifeStage.employee, '가계 재무현황', '/learn/money-household'),
    (LifeStage.selfEmployed, '변동소득 관리', '/learn/money-variable-income'),
    (LifeStage.farmer, '농지·계절 현금흐름', '/learn/re-farmland'),
    (LifeStage.family, '부부·가족 재무', '/learn/money-couple'),
    (LifeStage.preRetirement, '노후 준비', '/learn/pension-basics'),
    (LifeStage.retired, '연금·인출', '/learn/pension-cashflow'),
  ];
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.deepNavy,
            AppColors.navy,
            AppColors.teal.withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepNavy.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance, color: AppColors.gold, size: 36),
              const SizedBox(width: 12),
              Text(
                AppConstants.appName,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            AppConstants.appTagline,
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '밝고 전문적인 금융 교육 — 수익 보장·빠른 부자 환상 없이, '
            '본인 상황에 맞는 판단력을 기릅니다.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.88),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        color: AppColors.navy,
      ),
    );
  }
}

class _MoneyFlowDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const steps = [
      ('소득', Icons.payments),
      ('지출', Icons.shopping_cart_outlined),
      ('저축', Icons.savings_outlined),
      ('투자', Icons.trending_up),
      ('부채 상환', Icons.credit_card),
      ('세금·연금', Icons.receipt_long),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4,
          runSpacing: 8,
          children: [
            for (var i = 0; i < steps.length; i++) ...[
              _FlowStep(label: steps[i].$1, icon: steps[i].$2),
              if (i < steps.length - 1)
                Icon(Icons.arrow_forward, color: AppColors.teal, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}

class _FlowStep extends StatelessWidget {
  const _FlowStep({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.teal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.teal),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _AreaChip extends StatelessWidget {
  const _AreaChip({required this.label, required this.icon, this.onTap});

  final String label;
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(navIconData(icon), size: 18, color: AppColors.navy),
      label: Text(label),
      onPressed: onTap,
    );
  }

  IconData navIconData(String name) {
    const map = <String, IconData>{
      'school': Icons.school,
      'account_balance_wallet': Icons.account_balance_wallet,
      'savings': Icons.savings,
      'home': Icons.home,
      'show_chart': Icons.show_chart,
      'receipt_long': Icons.receipt_long,
      'monetization_on': Icons.monetization_on,
      'health_and_safety': Icons.health_and_safety,
      'credit_card': Icons.credit_card,
      'request_quote': Icons.request_quote,
      'elderly': Icons.elderly,
      'public': Icons.public,
      'security': Icons.security,
    };
    return map[name] ?? Icons.article_outlined;
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({
    required this.title,
    required this.subtitle,
    required this.route,
  });

  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        minVerticalPadding: 12,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.go(route),
      ),
    );
  }
}

class _SourceMiniTile extends StatelessWidget {
  const _SourceMiniTile({required this.name, required this.org});

  final String name;
  final String org;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.verified_outlined, color: AppColors.official),
      title: Text(name),
      subtitle: Text(org),
    );
  }
}
