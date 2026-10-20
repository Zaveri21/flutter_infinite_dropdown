# Flutter Infinite Dropdown

A fully customizable Flutter dropdown widget with built-in infinite scroll pagination — no boilerplate, just drop it in. 🚀

<p>
  <a href="https://pub.dev/packages/flutter_infinite_dropdown"><img src="https://img.shields.io/pub/v/flutter_infinite_dropdown.svg" alt="pub version"/></a>
  <a href="https://pub.dev/packages/flutter_infinite_dropdown/score"><img src="https://img.shields.io/pub/points/flutter_infinite_dropdown" alt="pub points"/></a>
  <a href="https://pub.dev/packages/flutter_infinite_dropdown/score"><img src="https://img.shields.io/pub/likes/flutter_infinite_dropdown" alt="pub likes"/></a>
  <a href="https://pub.dev/packages/flutter_infinite_dropdown/score"><img src="https://img.shields.io/pub/popularity/flutter_infinite_dropdown" alt="pub popularity"/></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License"/></a>
  <a href="https://github.com/Zaveri21/flutter_infinite_dropdown/issues"><img src="https://img.shields.io/github/issues-raw/Zaveri21/flutter_infinite_dropdown?style=flat" alt="GitHub issues"/></a>
  <img src="https://img.shields.io/github/last-commit/Zaveri21/flutter_infinite_dropdown" alt="last commit"/>
</p>

---

## Preview

<table>
  <tr>
    <td><img src="https://github.com/Zaveri21/flutter_infinite_dropdown/raw/main/gifs/android_flutter_dropdown.gif" alt="Android" width="300"></td>
    <td><img src="https://github.com/Zaveri21/flutter_infinite_dropdown/raw/main/gifs/ios_flutter_dropdown.gif" alt="iOS" width="300"></td>
  </tr>
  <tr>
    <td align="center"><b>Android</b></td>
    <td align="center"><b>iOS</b></td>
  </tr>
</table>

---

## Features

- Fully customizable dropdown list items via `itemBuilder`
- Infinite scroll pagination — fires `onBottomRefresh` when the user reaches the bottom
- Custom loading indicator (or use the default `CircularProgressIndicator`)
- Optional item dividers with `isSeparator`
- Controller API to stop the loader after your API call completes
- Zero external dependencies — only Flutter

---

## Installation

```console
flutter pub add flutter_infinite_dropdown
```

```dart
import 'package:flutter_infinite_dropdown/flutter_infinite_dropdown.dart';
```

> **Requires** Flutter ≥ 3.24.0 · Dart ≥ 3.5.0

---

## Quick Start

```dart
final controller = InfiniteDropdownController();
List<String> items = ['Apple', 'Banana', 'Cherry'];

InfiniteDropdown<String>(
  controller: controller,
  sourceWidget: const Text('Tap to open'),
  dropdownWidget: const SizedBox.shrink(),
  data: items,
  itemBuilder: (context, index, item) => ListTile(title: Text(item)),
  onBottomRefresh: () async {
    await Future.delayed(const Duration(seconds: 2));
    items.addAll(['Date', 'Elderberry', 'Fig']);
    controller.stopLoading(); // hide the loader
  },
)
```

---

## InfiniteDropdown

### Parameters

| Parameter               | Type                                              | Default  | Description                                                   |
|-------------------------|---------------------------------------------------|----------|---------------------------------------------------------------|
| `sourceWidget`          | `Widget`                                          | required | The widget that toggles the dropdown on tap                   |
| `dropdownWidget`        | `Widget`                                          | required | Reserved for custom dropdown header                           |
| `data`                  | `List<T>`                                         | required | Items to display in the list                                  |
| `itemBuilder`           | `Widget Function(BuildContext, int, T)`           | required | Builder for each list row                                     |
| `controller`            | `InfiniteDropdownController?`                     | `null`   | Controller to call `stopLoading()` after pagination completes |
| `onBottomRefresh`       | `Future<void> Function()?`                        | `null`   | Called when the user scrolls to the bottom of the list        |
| `dropdownHeight`        | `double?`                                         | `120`    | Height of the dropdown overlay                                |
| `spacing`               | `double?`                                         | `8.0`    | Gap between the source widget and the dropdown                |
| `isSeparator`           | `bool`                                            | `false`  | Show a `Divider` between list items                           |
| `progressIndicatorColor`| `Color?`                                          | `null`   | Color of the default loading indicator                        |
| `customIndicator`       | `Widget?`                                         | `null`   | Replace the default loader with a custom widget               |

### InfiniteDropdownController

| Method          | Description                                       |
|-----------------|---------------------------------------------------|
| `stopLoading()` | Hides the loading indicator at the bottom of the list |

---

## Examples

### Basic dropdown

```dart
InfiniteDropdown<String>(
  sourceWidget: Container(
    width: 200,
    height: 48,
    color: Colors.blue,
    child: const Center(
      child: Text('Select an item', style: TextStyle(color: Colors.white)),
    ),
  ),
  dropdownWidget: const SizedBox.shrink(),
  data: const ['Option A', 'Option B', 'Option C'],
  itemBuilder: (context, index, item) => ListTile(
    title: Text(item),
    onTap: () => debugPrint('Selected: $item'),
  ),
)
```

### Infinite scroll with pagination

```dart
class _MyState extends State<MyPage> {
  final controller = InfiniteDropdownController();
  List<String> items = List.generate(10, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return InfiniteDropdown<String>(
      controller: controller,
      sourceWidget: const Text('Open'),
      dropdownWidget: const SizedBox.shrink(),
      data: items,
      dropdownHeight: 220,
      isSeparator: true,
      itemBuilder: (context, index, item) => ListTile(title: Text(item)),
      onBottomRefresh: () async {
        // Simulate network call
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          items.addAll(List.generate(10, (i) => 'Item ${items.length + i}'));
        });
        controller.stopLoading();
      },
    );
  }
}
```

### Custom loading indicator

```dart
InfiniteDropdown<String>(
  sourceWidget: const Text('Open'),
  dropdownWidget: const SizedBox.shrink(),
  data: items,
  itemBuilder: (context, index, item) => ListTile(title: Text(item)),
  customIndicator: const Padding(
    padding: EdgeInsets.all(12),
    child: Center(child: Text('Loading more…')),
  ),
)
```

---

## Platform Support

| Android | iOS | Web | macOS | Linux | Windows |
|:-------:|:---:|:---:|:-----:|:-----:|:-------:|
| ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

---

## Additional Information

- **Issues & feature requests**: [GitHub issue tracker](https://github.com/Zaveri21/flutter_infinite_dropdown/issues)
- **Contributions**: Pull requests are welcome on [GitHub](https://github.com/Zaveri21/flutter_infinite_dropdown)

---

<p align="center">
  <b>If this package saved you time, a coffee would be appreciated ☕</b><br/><br/>
  <a href="https://www.buymeacoffee.com/vishaljhaveri" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45">
  </a>
  <br/><br/>
  <a href="/LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License">
  </a>
  &nbsp;
  <b>MIT © <a href="https://github.com/Zaveri21">Vishal Zaveri</a></b>
</p>
