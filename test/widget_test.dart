import 'package:flutter_test/flutter_test.dart';

import 'package:ongii_project/app.dart';

void main() {
  testWidgets('App renders and navigation switches pages', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const OngiiApp());
    await tester.pumpAndSettle();

    expect(find.text('Calendar'), findsAtLeastNWidgets(1));
    expect(find.text('Feed'), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);
    expect(find.text('My'), findsOneWidget);

    await tester.tap(find.text('Feed'));
    await tester.pumpAndSettle();
    expect(find.text('Pinned notice'), findsOneWidget);

    await tester.tap(find.text('Chat'));
    await tester.pumpAndSettle();
    expect(find.text('Family Chat'), findsOneWidget);
  });
}
