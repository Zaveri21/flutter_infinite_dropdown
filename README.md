TODO: This Flutter package helps create a dropdown which is fully customized And also provides a feature pagination.

## Features

TODO: 
- You can show custom loader in dropdown.  
- You can customized dropdown list item.
- provide pagination feature. 


## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: To use this package, add flutter_infinite_dropdown as a dependency in your [pubspec.yaml] file. And add this import to your file
to `import 'package:flutter_infinite_dropdown/flutter_infinite_dropdown.dart';
` 

```dart
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

 ## Additional information

<!--TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more. -->

<a href="https://www.buymeacoffee.com/vishaljhavu" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

<a href="https://opensource.org/licenses/MIT" target="_blank"><img src="https://img.shields.io/badge/License-MIT-yellow.svg"/></a>
<a href="https://opensource.org/licenses/Apache-2.0" target="_blank"><img src="https://badges.frapsoft.com/os/v1/open-source.svg?v=102"/></a>
<a href="https://github.com/Zaveri21/flutter_infinite_dropdown/issues" target="_blank"><img alt="GitHub: bhoominn" src="https://img.shields.io/github/issues-raw/Zaveri21/flutter_infinite_dropdown?style=flat" /></a>
<img src="https://img.shields.io/github/last-commit/Zaveri21/flutter_infinite_dropdown" />

<a href="https://github.com/bhooZaveri21"><img alt="GitHub: Zaveri21" src="https://img.shields.io/github/followers/Zaveri21?label=Follow&style=social" /></a>
<a href="https://github.com/Zaveri21/flutter_infinite_dropdown"><img src="https://img.shields.io/github/stars/Zaveri21/flutter_infinite_dropdown?style=social" /></a>

<a href="https://saythanks.io/to/Zaveri21" target="_blank"><img src="https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg"/></a> ss

## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)
