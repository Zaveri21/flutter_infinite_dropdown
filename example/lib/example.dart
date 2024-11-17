import 'package:flutter/material.dart';
import 'package:flutter_infinite_dropdown/flutter_infinite_dropdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> lsData = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  InfiniteDropdownController controller = InfiniteDropdownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Infinite Dropdown'),
      ),
      body: Center(
        child: Column(
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
              itemBuilder: (context, index, item) => ListTile(
                title: Text('Option $index'),
                onTap: () {
                  print('Option 1 selected');
                },
              ),
              onBottomRefresh: () async {
                try {
                  //   Future.delayed(Duration(seconds: 2), () {
                  //   lsData.addAll(['11','12','13','14','15','16','17','18','19','20']);

                  //  });
                  Future.delayed(Duration(seconds: 2), () {
                    lsData.addAll([
                      '11',
                      '12',
                      '13',
                      '14',
                      '15',
                      '16',
                      '17',
                      '18',
                      '19',
                      '20'
                    ]);
                    controller.stopLoading();
                  });
                } catch (ex) {
                  print("Error: $ex");
                }
              },
              dropdownWidget: Container(),
            )
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
