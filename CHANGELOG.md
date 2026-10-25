## 1.0.4

- **Security:** Bumped minimum SDK to Dart ≥ 3.13.7 / Flutter ≥ 3.47.8 to address a Dart HTTPS certificate validation vulnerability. No API changes.

## 1.0.3

- Bumped minimum SDK to Dart ≥ 3.5.0 / Flutter ≥ 3.24.0 (latest stable support).
- Added platform declarations for Web, macOS, Linux, and Windows.
- Fixed memory leak: overlay entry is now removed in `dispose()` when the dropdown is open.
- Fixed redundant `setState` wrapping a `ValueNotifier` update in `_onScroll`.
- Added `hasClients` guard before `ScrollController.jumpTo()` in post-frame callback.
- Made `controller` parameter optional (was incorrectly marked `required` while nullable).
- Added `super.key` to widget constructor.
- Applied `const` constructors throughout (`BouncingScrollPhysics`, `Divider`, `EdgeInsets`, etc.).
- Replaced empty `Container()` separators with `SizedBox.shrink()`.
- Moved `flutter_test` from `dependencies` to `dev_dependencies`.
- Added comprehensive package-level tests in `test/`.
- Updated README with full parameter table, examples, and platform support matrix.


## 1.0.2+3

- Minor code structure changes.
- Version bump.
- Readme file updated.


## 1.0.2+2

- Readme file updated.
- Code format.


## 1.0.2+1

- Readme file updated.


## 1.0.2

- Minor improvements. Supported platforms updated.


## 1.0.1

- Major dependencies updated (lints package upgraded).


## 1.0.0

- Initial version.
