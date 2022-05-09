import 'package:flutter/material.dart';
import 'package:http/http.dart';


main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HttpApp(),
    );
  }
}



class HttpApp extends StatefulWidget {
  const HttpApp({ Key? key }) : super(key: key);

  @override
  State<HttpApp> createState() => _HttpApp();
}

class _HttpApp extends State<HttpApp> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP 통신 테스트'),
      ),
      body: Container(
        child: Center(child: Text('$result')),

      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        /* 떠있는 버튼(움직이지는 않음) */

      },
      child: Icon(Icons.file_download),
      ),

    );
  }
}