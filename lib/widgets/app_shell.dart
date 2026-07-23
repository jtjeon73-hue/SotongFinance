import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/accessibility_settings.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../data/nav_data.dart';
import '../models/nav_models.dart';
import 'disclaimer_banner.dart';

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
    'calculate': Icons.calculate,
    'menu_book': Icons.menu_book,
    'history': Icons.history,
    'search': Icons.search,
    'info': Icons.info_outline,
  };
  return map[name] ?? Icons.article_outlined;
}

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onNavigate(String route) {
    if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
      Navigator.of(context).pop();
    }
    context.go(route);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final isDesktop =
        MediaQuery.sizeOf(context).width >= AppConstants.desktopBreakpoint;

    return Scaffold(
      key: _scaffoldKey,
      appBar: isDesktop
          ? null
          : AppBar(
              title: Semantics(
                header: true,
                child: const Text('SotongFinance'),
              ),
              leading: Semantics(
                button: true,
                label: '메뉴 열기',
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  tooltip: '메뉴',
                ),
              ),
              actions: [
                Semantics(
                  button: true,
                  label: '글자 크기 변경',
                  child: IconButton(
                    icon: const Icon(Icons.text_fields),
                    onPressed: () =>
                        AccessibilitySettings.of(context).cycleTextScale(),
                    tooltip: AccessibilitySettings.of(context).label,
                  ),
                ),
                Semantics(
                  button: true,
                  label: '검색',
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _onNavigate('/search'),
                    tooltip: '검색',
                  ),
                ),
              ],
            ),
      drawer: isDesktop
          ? null
          : Drawer(
              child: _NavPanel(
                location: location,
                onNavigate: _onNavigate,
                showHeader: true,
              ),
            ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            SizedBox(
              width: AppConstants.sidebarWidth,
              child: Material(
                elevation: 1,
                child: _NavPanel(
                  location: location,
                  onNavigate: _onNavigate,
                  showHeader: true,
                ),
              ),
            ),
          Expanded(
            child: ColoredBox(
              color: AppColors.lightGray,
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: isDesktop,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (isDesktop) _DesktopTopBar(onNavigate: _onNavigate),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: AppConstants.contentMaxWidth,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              isDesktop ? 28 : 16,
                              isDesktop ? 24 : 12,
                              isDesktop ? 28 : 16,
                              24,
                            ),
                            child: widget.child,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: AppConstants.contentMaxWidth,
                            ),
                            child: DisclaimerBanner(compact: true),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopTopBar extends StatelessWidget {
  const _DesktopTopBar({required this.onNavigate});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.deepNavy,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          Semantics(
            header: true,
            button: true,
            label: 'SotongFinance 홈',
            child: InkWell(
              onTap: () => onNavigate('/'),
              child: Row(
                children: [
                  Icon(Icons.account_balance, color: AppColors.gold),
                  const SizedBox(width: 10),
                  Text(
                    'SotongFinance',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Semantics(
            button: true,
            label: '글자 크기 변경',
            child: TextButton.icon(
              onPressed: () =>
                  AccessibilitySettings.of(context).cycleTextScale(),
              icon: const Icon(Icons.text_fields, color: Colors.white70),
              label: Text(
                AccessibilitySettings.of(context).label,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ),
          Semantics(
            button: true,
            label: '검색',
            child: TextButton.icon(
              onPressed: () => onNavigate('/search'),
              icon: const Icon(Icons.search, color: Colors.white70),
              label: const Text('검색', style: TextStyle(color: Colors.white70)),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavPanel extends StatelessWidget {
  const _NavPanel({
    required this.location,
    required this.onNavigate,
    required this.showHeader,
  });

  final String location;
  final ValueChanged<String> onNavigate;
  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          if (showHeader)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                '학습 메뉴',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
            ),
          ...appNavGroups.map(
            (group) => _NavGroupTile(
              group: group,
              location: location,
              onNavigate: onNavigate,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavGroupTile extends StatelessWidget {
  const _NavGroupTile({
    required this.group,
    required this.location,
    required this.onNavigate,
  });

  final NavGroup group;
  final String location;
  final ValueChanged<String> onNavigate;

  bool get _groupHasActive {
    return group.items.any((item) => _isActive(item.route, location));
  }

  bool _isActive(String route, String loc) {
    if (route == '/') return loc == '/';
    if (route == '/tools') {
      return loc == '/tools' || loc.startsWith('/tools/');
    }
    if (route == '/scenarios') {
      return loc == '/scenarios' || loc.startsWith('/scenarios/');
    }
    return loc == route || loc.startsWith('$route/');
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: group.initiallyExpanded || _groupHasActive,
      leading: Icon(navIconData(group.icon), color: AppColors.teal),
      title: Text(
        group.title,
        style: TextStyle(
          fontWeight: _groupHasActive ? FontWeight.w700 : FontWeight.w500,
          color: _groupHasActive ? AppColors.navy : AppColors.textPrimary,
        ),
      ),
      children: group.items.map((item) {
        final active = _isActive(item.route, location);
        return Semantics(
          button: true,
          selected: active,
          label: item.title,
          child: ListTile(
            dense: true,
            minVerticalPadding: 12,
            contentPadding: const EdgeInsets.only(left: 56, right: 16),
            selected: active,
            selectedTileColor: AppColors.teal.withValues(alpha: 0.1),
            title: Text(
              item.title,
              style: TextStyle(
                fontWeight: active ? FontWeight.w700 : FontWeight.normal,
                color: active ? AppColors.teal : AppColors.textPrimary,
              ),
            ),
            onTap: () => onNavigate(item.route),
          ),
        );
      }).toList(),
    );
  }
}
