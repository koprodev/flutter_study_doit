import 'package:flutter/material.dart';

class ImageWidgetApp extends StatefulWidget {
  const ImageWidgetApp({Key? key}) : super(key: key);

  @override
  State<ImageWidgetApp> createState() => _ImageWidgetApp();
}

class _ImageWidgetApp extends State<ImageWidgetApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Image & Font Widget')),
        body: Container(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('image/AI.png',
                width: 200, height: 100, fit: BoxFit.scaleDown),
            const Text(
              'GRTech co Ltd\n지알테크',
              style: TextStyle(
                  fontFamily: 'Binggrae', fontSize: 30, color: Colors.blue),
              textAlign: TextAlign.center,
            )
          ],
        ))));
  }
}
