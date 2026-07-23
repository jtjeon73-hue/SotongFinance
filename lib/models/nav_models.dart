class NavItem {
  const NavItem({
    required this.id,
    required this.title,
    required this.route,
    this.contentId,
  });

  final String id;
  final String title;
  final String route;
  final String? contentId;
}

class NavGroup {
  const NavGroup({
    required this.id,
    required this.title,
    required this.icon,
    required this.items,
    this.initiallyExpanded = false,
  });

  final String id;
  final String title;
  final String icon;
  final List<NavItem> items;
  final bool initiallyExpanded;
}
