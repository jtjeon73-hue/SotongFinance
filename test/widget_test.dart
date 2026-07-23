import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_finance/app/app.dart';

void main() {
  testWidgets('SotongFinanceApp builds', (tester) async {
    await tester.pumpWidget(const SotongFinanceApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('SotongFinance'), findsWidgets);
  });
}
