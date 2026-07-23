import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/about_screen.dart';
import '../screens/calculator_screen.dart';
import '../screens/content_detail_screen.dart';
import '../screens/diagnosis_screen.dart';
import '../screens/glossary_screen.dart';
import '../screens/home_screen.dart';
import '../screens/life_paths_screen.dart';
import '../screens/project_report_screen.dart';
import '../screens/prompts_screen.dart';
import '../screens/scenario_detail_screen.dart';
import '../screens/scenarios_screen.dart';
import '../screens/search_screen.dart';
import '../screens/sources_screen.dart';
import '../screens/tools_list_screen.dart';
import '../widgets/app_shell.dart';

const _toolSlugToCalcId = <String, String>{
  'net-worth': 'calc-net-worth',
  'cashflow': 'calc-cashflow',
  'savings-rate': 'calc-savings-rate',
  'simple-interest': 'calc-simple',
  'compound-interest': 'calc-compound',
  'real-return': 'calc-real-return',
  'loan-payment': 'calc-loan-payment',
  'equal-payment': 'calc-equal-payment',
  'equal-principal': 'calc-equal-principal',
  'invest-return': 'calc-invest-return',
  'rental-yield': 'calc-rental-yield',
  'retirement-gap': 'calc-retirement-gap',
  'pension-sum': 'calc-pension-sum',
  'future-cost': 'calc-future-cost',
  'debt-burden': 'calc-debt-burden',
  'emergency-months': 'calc-emergency-months',
  'net-rent': 'calc-net-rent',
  'acquisition-cost': 'calc-acquisition-cost',
  'etf-fee': 'calc-etf-fee',
  'recovery': 'calc-recovery',
  'rate-stress': 'calc-rate-stress',
  'vacancy-stress': 'calc-vacancy-stress',
  'sequence-risk': 'calc-sequence-risk',
  'variable-income': 'calc-variable-income',
  'retirement-cashflow': 'calc-retirement-cashflow',
  'debt-interest': 'calc-debt-interest',
  'allocation-shift': 'calc-allocation-shift',
};

String? calcIdFromToolSlug(String slug) => _toolSlugToCalcId[slug];

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/learn/:id',
          name: 'learn',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return NoTransitionPage(child: ContentDetailScreen(contentId: id));
          },
        ),
        GoRoute(
          path: '/tools',
          name: 'tools',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ToolsListScreen()),
          routes: [
            GoRoute(
              path: ':slug',
              name: 'tool',
              pageBuilder: (context, state) {
                final slug = state.pathParameters['slug']!;
                final calcId = calcIdFromToolSlug(slug);
                if (calcId == null) {
                  return NoTransitionPage(
                    child: Scaffold(
                      body: Center(child: Text('알 수 없는 계산기: $slug')),
                    ),
                  );
                }
                return NoTransitionPage(
                  child: CalculatorScreen(calcId: calcId),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/diagnose',
          name: 'diagnose',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: DiagnosisScreen()),
        ),
        GoRoute(
          path: '/paths',
          name: 'paths',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LifePathsScreen()),
        ),
        GoRoute(
          path: '/search',
          name: 'search',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SearchScreen()),
        ),
        GoRoute(
          path: '/glossary',
          name: 'glossary',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: GlossaryScreen()),
        ),
        GoRoute(
          path: '/sources',
          name: 'sources',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SourcesScreen()),
        ),
        GoRoute(
          path: '/scenarios',
          name: 'scenarios',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ScenariosScreen()),
          routes: [
            GoRoute(
              path: ':id',
              name: 'scenario',
              pageBuilder: (context, state) {
                final id = state.pathParameters['id']!;
                return NoTransitionPage(
                  child: ScenarioDetailScreen(scenarioId: id),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/prompts',
          name: 'prompts',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: PromptsScreen()),
        ),
        GoRoute(
          path: '/about',
          name: 'about',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: AboutScreen()),
        ),
        GoRoute(
          path: '/project/report',
          name: 'projectReport',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProjectReportScreen()),
        ),
      ],
    ),
  ],
);
