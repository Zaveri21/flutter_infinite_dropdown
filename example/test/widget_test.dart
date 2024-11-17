import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_dropdown/flutter_infinite_dropdown.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyHomePage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Wait for the widget to fully render.
    await tester.pumpAndSettle();

    // Verify that the AppBar title is correct.
    expect(find.text('Infinite Dropdown'), findsOneWidget);

    // Verify that the InfiniteDropdown widget is not displayed initially.
    expect(find.byType(InfiniteDropdown), findsNothing);

    // Verify that the InfiniteDropdown widget is not displayed initially.
    expect(find.byType(InfiniteDropdown), findsNothing);

    // Tap on the source widget to open the dropdown.
    await tester.tap(find.text('Tap here to open dropdown'));
    await tester.pumpAndSettle();

    // Find the ListView
    final listViewFinder = find.byType(ListView);

    // Scroll to the bottom of the ListView
    await tester.drag(listViewFinder, const Offset(0.0, -500.0));
    await tester.pumpAndSettle();
  });
}
