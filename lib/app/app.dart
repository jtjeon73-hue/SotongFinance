import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'accessibility_settings.dart';
import 'router.dart';

class SotongFinanceApp extends StatefulWidget {
  const SotongFinanceApp({super.key});

  @override
  State<SotongFinanceApp> createState() => _SotongFinanceAppState();
}

class _SotongFinanceAppState extends State<SotongFinanceApp> {
  static const _scales = <double>[1.0, 1.25, 1.5];
  int _scaleIndex = 0;

  void _cycleTextScale() {
    setState(() => _scaleIndex = (_scaleIndex + 1) % _scales.length);
  }

  @override
  Widget build(BuildContext context) {
    final scale = _scales[_scaleIndex];
    return AccessibilitySettings(
      textScale: scale,
      cycleTextScale: _cycleTextScale,
      child: MaterialApp.router(
        title: 'SotongFinance',
        theme: AppTheme.light,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          final mq = MediaQuery.of(context);
          return MediaQuery(
            data: mq.copyWith(textScaler: TextScaler.linear(scale)),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
