import 'package:flutter/material.dart';
import 'imageWidget.dart';

main() {
  runApp(MyApp());
}
//aaa

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageWidgetApp(),
    );
  }
}
