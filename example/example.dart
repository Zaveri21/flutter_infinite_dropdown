// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_infinite_dropdown/flutter_infinite_dropdown.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Basic dropdown — no pagination
// ─────────────────────────────────────────────────────────────────────────────

Widget basicDropdown() {
  return InfiniteDropdown<String>(
    sourceWidget: Container(
      width: 200,
      height: 48,
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Select an item',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    dropdownWidget: const SizedBox.shrink(),
    data: const ['Option A', 'Option B', 'Option C'],
    dropdownHeight: 180,
    itemBuilder: (context, index, item) => ListTile(
      title: Text(item),
      onTap: () => debugPrint('Selected: $item'),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Infinite scroll with pagination
// ─────────────────────────────────────────────────────────────────────────────

// Stateful usage — put this inside a State class:
//
//   final controller = InfiniteDropdownController();
//   List<String> items = List.generate(10, (i) => 'Item $i');
//
//   InfiniteDropdown<String>(
//     controller: controller,
//     sourceWidget: const Text('Open'),
//     dropdownWidget: const SizedBox.shrink(),
//     data: items,
//     dropdownHeight: 220,
//     isSeparator: true,
//     itemBuilder: (context, index, item) => ListTile(title: Text(item)),
//     onBottomRefresh: () async {
//       await Future.delayed(const Duration(seconds: 2));
//       setState(() {
//         items.addAll(List.generate(10, (i) => 'Item ${items.length + i}'));
//       });
//       controller.stopLoading();
//     },
//   )

// ─────────────────────────────────────────────────────────────────────────────
// Custom loading indicator
// ─────────────────────────────────────────────────────────────────────────────

Widget customLoaderDropdown() {
  return InfiniteDropdown<String>(
    sourceWidget: const Text('Open'),
    dropdownWidget: const SizedBox.shrink(),
    data: const ['A', 'B', 'C'],
    itemBuilder: (context, index, item) => ListTile(title: Text(item)),
    customIndicator: const Padding(
      padding: EdgeInsets.all(12),
      child: Center(child: Text('Loading more…')),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Dropdown with separators and custom color indicator
// ─────────────────────────────────────────────────────────────────────────────

Widget separatorDropdown() {
  return InfiniteDropdown<String>(
    sourceWidget: const Text('Open'),
    dropdownWidget: const SizedBox.shrink(),
    data: const ['Item 1', 'Item 2', 'Item 3'],
    isSeparator: true,
    progressIndicatorColor: Colors.deepPurple,
    itemBuilder: (context, index, item) => ListTile(title: Text(item)),
  );
}
