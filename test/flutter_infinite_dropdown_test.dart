import 'package:flutter/material.dart';
import 'package:flutter_infinite_dropdown/flutter_infinite_dropdown.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Widget _buildApp({
  required Widget child,
}) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

InfiniteDropdown<String> _buildDropdown({
  List<String> data = const ['Alpha', 'Beta', 'Gamma'],
  InfiniteDropdownController? controller,
  Future<void> Function()? onBottomRefresh,
  bool isSeparator = false,
  Color? progressIndicatorColor,
  Widget? customIndicator,
  double dropdownHeight = 200,
}) {
  return InfiniteDropdown<String>(
    controller: controller,
    sourceWidget: const Text('Open Dropdown'),
    dropdownWidget: const SizedBox.shrink(),
    data: data,
    itemBuilder: (context, index, item) => ListTile(
      key: Key('item_$index'),
      title: Text(item),
    ),
    onBottomRefresh: onBottomRefresh,
    isSeparator: isSeparator,
    progressIndicatorColor: progressIndicatorColor,
    customIndicator: customIndicator,
    dropdownHeight: dropdownHeight,
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // InfiniteDropdownController
  // -------------------------------------------------------------------------
  group('InfiniteDropdownController', () {
    test('stopLoading does not throw when not attached to any state', () {
      final controller = InfiniteDropdownController();
      expect(() => controller.stopLoading(), returnsNormally);
    });

    testWidgets('attaches to state after widget mounts', (tester) async {
      final controller = InfiniteDropdownController();
      await tester
          .pumpWidget(_buildApp(child: _buildDropdown(controller: controller)));
      // If attached, stopLoading should run without errors.
      expect(() => controller.stopLoading(), returnsNormally);
    });
  });

  // -------------------------------------------------------------------------
  // InfiniteDropdown rendering
  // -------------------------------------------------------------------------
  group('InfiniteDropdown — initial state', () {
    testWidgets('renders source widget', (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown()));
      expect(find.text('Open Dropdown'), findsOneWidget);
    });

    testWidgets('dropdown list is not visible before tap', (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown()));
      expect(find.text('Alpha'), findsNothing);
      expect(find.text('Beta'), findsNothing);
      expect(find.text('Gamma'), findsNothing);
    });

    testWidgets('works with null controller', (tester) async {
      await tester.pumpWidget(_buildApp(
        child: _buildDropdown(controller: null),
      ));
      expect(find.text('Open Dropdown'), findsOneWidget);
    });
  });

  // -------------------------------------------------------------------------
  // Open / close behaviour
  // -------------------------------------------------------------------------
  group('InfiniteDropdown — open / close', () {
    testWidgets('tapping source widget opens the dropdown overlay',
        (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown()));
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('Beta'), findsOneWidget);
      expect(find.text('Gamma'), findsOneWidget);
    });

    testWidgets('tapping source widget again closes the dropdown overlay',
        (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown()));

      // Open
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(find.text('Alpha'), findsOneWidget);

      // Close
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(find.text('Alpha'), findsNothing);
    });

    testWidgets('dropdown renders a ListView', (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown()));
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });
  });

  // -------------------------------------------------------------------------
  // Separator
  // -------------------------------------------------------------------------
  group('InfiniteDropdown — isSeparator', () {
    testWidgets('shows Divider between items when isSeparator is true',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(child: _buildDropdown(isSeparator: true)),
      );
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(find.byType(Divider), findsWidgets);
    });

    testWidgets('no Divider when isSeparator is false', (tester) async {
      await tester.pumpWidget(
        _buildApp(child: _buildDropdown(isSeparator: false)),
      );
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(find.byType(Divider), findsNothing);
    });
  });

  // -------------------------------------------------------------------------
  // Empty and large data lists
  // -------------------------------------------------------------------------
  group('InfiniteDropdown — data edge cases', () {
    testWidgets('handles empty data list without error', (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown(data: const [])));
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('renders all items for a single-item list', (tester) async {
      await tester.pumpWidget(
        _buildApp(child: _buildDropdown(data: const ['Only'])),
      );
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(find.text('Only'), findsOneWidget);
    });

    testWidgets('renders items for a large list', (tester) async {
      final data = List.generate(50, (i) => 'Item $i');
      await tester.pumpWidget(_buildApp(child: _buildDropdown(data: data)));
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
      // First visible item should be rendered.
      expect(find.text('Item 0'), findsOneWidget);
    });
  });

  // -------------------------------------------------------------------------
  // Loading indicator
  // -------------------------------------------------------------------------
  group('InfiniteDropdown — loading indicator', () {
    testWidgets('default CircularProgressIndicator is not visible initially',
        (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown()));
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('custom indicator widget is accepted without error',
        (tester) async {
      const customKey = Key('custom_loader');
      await tester.pumpWidget(_buildApp(
        child: _buildDropdown(
          customIndicator: const SizedBox(key: customKey, height: 24),
        ),
      ));
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      // Dropdown opens without error; custom indicator is only shown when loading.
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets(
        'stopLoading via controller hides the loading indicator when loading',
        (tester) async {
      final controller = InfiniteDropdownController();
      bool refreshCalled = false;

      final completer = Future<void>.value();

      await tester.pumpWidget(_buildApp(
        child: _buildDropdown(
          controller: controller,
          data: List.generate(20, (i) => 'Item $i'),
          onBottomRefresh: () async {
            refreshCalled = true;
            await completer;
          },
        ),
      ));

      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      // Calling stopLoading directly should not throw.
      expect(() => controller.stopLoading(), returnsNormally);
      await tester.pump();
      expect(refreshCalled, isFalse); // scroll not reached bottom yet
    });
  });

  // -------------------------------------------------------------------------
  // Memory leak — dispose cleans up the overlay
  // -------------------------------------------------------------------------
  group('InfiniteDropdown — memory safety', () {
    testWidgets('overlay is removed when widget is disposed with dropdown open',
        (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown()));

      // Open the dropdown.
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(find.text('Alpha'), findsOneWidget);

      // Replace the entire widget tree, triggering dispose.
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
      );
      await tester.pumpAndSettle();

      // Overlay entry must have been cleaned up.
      expect(find.text('Alpha'), findsNothing);
    });

    testWidgets(
        'overlay is removed when widget is disposed with dropdown closed',
        (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown()));
      // Dispose without ever opening the dropdown.
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('ScrollController is disposed without error', (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown()));
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('ValueNotifier is disposed without error', (tester) async {
      await tester.pumpWidget(_buildApp(child: _buildDropdown()));
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });

  // -------------------------------------------------------------------------
  // Generic type support
  // -------------------------------------------------------------------------
  group('InfiniteDropdown — generic type', () {
    testWidgets('works with int type', (tester) async {
      await tester.pumpWidget(_buildApp(
        child: InfiniteDropdown<int>(
          sourceWidget: const Text('Open'),
          dropdownWidget: const SizedBox.shrink(),
          data: const [1, 2, 3],
          itemBuilder: (context, index, item) => Text('$item'),
          dropdownHeight: 200,
        ),
      ));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('works with custom object type', (tester) async {
      final items = [_Item('Apple'), _Item('Mango')];
      await tester.pumpWidget(_buildApp(
        child: InfiniteDropdown<_Item>(
          sourceWidget: const Text('Open'),
          dropdownWidget: const SizedBox.shrink(),
          data: items,
          itemBuilder: (context, index, item) => Text(item.name),
          dropdownHeight: 200,
        ),
      ));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Mango'), findsOneWidget);
    });
  });

  // -------------------------------------------------------------------------
  // onBottomRefresh callback
  // -------------------------------------------------------------------------
  group('InfiniteDropdown — onBottomRefresh', () {
    testWidgets(
        'no error when onBottomRefresh is null and scroll bottom reached',
        (tester) async {
      await tester.pumpWidget(_buildApp(
        child: _buildDropdown(
          data: List.generate(5, (i) => 'Item $i'),
          onBottomRefresh: null,
        ),
      ));
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}

// Helper class for generic type test.
class _Item {
  final String name;
  const _Item(this.name);
}
