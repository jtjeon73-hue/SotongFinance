import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_finance/app/app.dart';

void main() {
  testWidgets('SotongFinanceApp builds', (tester) async {
    await tester.pumpWidget(const SotongFinanceApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('SotongFinance'), findsWidgets);
  });

  testWidgets('mobile drawer opens with semantics labels', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SotongFinanceApp());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.bySemanticsLabel('메뉴 열기'), findsOneWidget);
    expect(find.bySemanticsLabel('검색'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('메뉴 열기'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(Drawer), findsOneWidget);
  });

  testWidgets('min touch target for menu button', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SotongFinanceApp());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    final menuSize = tester.getSize(find.bySemanticsLabel('메뉴 열기'));
    expect(menuSize.width, greaterThanOrEqualTo(48));
    expect(menuSize.height, greaterThanOrEqualTo(48));
  });
}
