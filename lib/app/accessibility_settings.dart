import 'package:flutter/material.dart';

/// 앱 전역 글자 확대(브라우저/OS 설정과 독립적으로 1.0 / 1.25 / 1.5 순환)
class AccessibilitySettings extends InheritedWidget {
  const AccessibilitySettings({
    super.key,
    required this.textScale,
    required this.cycleTextScale,
    required super.child,
  });

  final double textScale;
  final VoidCallback cycleTextScale;

  static AccessibilitySettings of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AccessibilitySettings>();
    assert(scope != null, 'AccessibilitySettings not found');
    return scope!;
  }

  static AccessibilitySettings? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AccessibilitySettings>();
  }

  String get label {
    if (textScale >= 1.45) return '큰 글씨(최대)';
    if (textScale >= 1.2) return '큰 글씨';
    return '기본 글씨';
  }

  @override
  bool updateShouldNotify(AccessibilitySettings oldWidget) {
    return textScale != oldWidget.textScale;
  }
}
