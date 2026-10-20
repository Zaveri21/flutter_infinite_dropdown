import 'package:example/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyHomePage renders AppBar with correct title', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Infinite Dropdown'), findsOneWidget);
  });

  testWidgets('InfiniteDropdown source widget is visible', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Tap here to open dropdown'), findsOneWidget);
  });

  testWidgets('Dropdown list is hidden before tap', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Option 1'), findsNothing);
  });

  testWidgets('Tapping source widget opens the dropdown', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tap here to open dropdown'));
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Option 1'), findsOneWidget);
  });

  testWidgets('Tapping source widget again closes the dropdown', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tap here to open dropdown'));
    await tester.pumpAndSettle();
    expect(find.text('Option 1'), findsOneWidget);

    await tester.tap(find.text('Tap here to open dropdown'));
    await tester.pumpAndSettle();
    expect(find.text('Option 1'), findsNothing);
  });

  testWidgets('Scrolling dropdown does not throw', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tap here to open dropdown'));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0.0, -200.0));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
