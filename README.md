This Flutter package helps create a dropdown which is fully customized And also provides a feature pagination.

<a href="https://opensource.org/licenses/MIT" target="_blank"><img src="https://img.shields.io/badge/License-MIT-yellow.svg"/></a>
<a href="https://opensource.org/licenses/Apache-2.0" target="_blank"><img src="https://badges.frapsoft.com/os/v1/open-source.svg?v=102"/></a>
<a href="https://github.com/Zaveri21/flutter_infinite_dropdown/issues" target="_blank"><img alt="GitHub: Zaveri21" src="https://img.shields.io/github/issues-raw/Zaveri21/flutter_infinite_dropdown?style=flat" /></a>
<img src="https://img.shields.io/github/last-commit/Zaveri21/flutter_infinite_dropdown" />

## ✨ Features 
- ⭐️ custom loader in dropdown.  
- ⭐️ customized dropdown list item.
- ⭐️ pagination support. 
- ⭐️ each item divider optional support.

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


## **Installation**
 Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_infinite_dropdown: ^1.0.0
```

```dart
import 'package:flutter_infinite_dropdown/flutter_infinite_dropdown.dart';
```

## Usage
To use this package, add flutter_infinite_dropdown as a dependency in your `pubspec.yaml` file. And add this import to your file to `import 'package:flutter_infinite_dropdown/flutter_infinite_dropdown.dart';
` 

```dart
// Usage Example
Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    InfiniteDropdown(
        controller: controller,
        sourceWidget: Container(
        width: 200,
        height: 40,
        color: Colors.blue,
        child: Center(
            child: Text(
            'Tap here to open dropdown',
            style: TextStyle(color: Colors.white),
            ),
        ),
        ),
        data: lsData,
        itemBuilder: (context, index) => ListTile(
        title: Text('Option $index'),
        onTap: () {
            print('Option 1 selected');
        },
        ),
        onBottomRefresh: () async {
            try {
                    Future.delayed(Duration(seconds: 2), () {
                    lsData.addAll(['11', '12', '13', '14', '15', '16', '17', '18', '19', '20']);
                    
                    controller.stopLoading();// <--- Stop loader
                    });
                } catch (ex) {
                     print("Error: $ex");
                }
            },
            dropdownWidget: Container(),
        )
    ],
)
```

## ⏳ Work-in-Progress (WIP)
- 🖥️ Web support (WIP).

 ## Additional Information

Tell users more about the package: where to find more information, how to contribute to the package, how to file issues, what response they can expect from the package authors, and more.

### Support Me
<a href="https://www.buymeacoffee.com/vishaljhavu" target="_blank">
  <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 20px !important;width: 86px !important;" >
</a>

### GitHub
<a href="https://github.com/Zaveri21/flutter_infinite_dropdown">
  <img src="https://img.shields.io/github/stars/Zaveri21/flutter_infinite_dropdown?style=social" alt="GitHub Stars" />
</a>
<a href="https://github.com/Zaveri21">
  <img src="https://img.shields.io/github/followers/Zaveri21?label=Follow&style=social" alt="GitHub Followers" />
</a>

### Say Thanks
<a href="https://saythanks.io/to/Zaveri21" target="_blank">
  <img src="https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg" alt="Say Thanks" />
</a>

## License

<a href="/LICENSE">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT" style="style="height: 20px">
</a>

