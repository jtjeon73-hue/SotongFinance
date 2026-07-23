import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'router.dart';

class SotongFinanceApp extends StatelessWidget {
  const SotongFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SotongFinance',
      theme: AppTheme.light,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
