import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class FileApp extends StatefulWidget {
  const FileApp({ Key? key }) : super(key: key);

  @override
  State<FileApp> createState() => _FileApp();
}




class _FileApp extends State<FileApp> {

  int _count = 0;

  @override
  void initState() {
    super.initState();
    readCountFile();
  }

  /* --------------------- */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('파일저장 테스트'),
      ),
      body: Container(
        child: Center(
          child: Text(
            '$_count',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count ++;
          });
          writeCountFile(_count);
        },
        child: Icon(Icons.add),

      ),
    );
  }






  /* --------------------- */


  void readCountFile() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '/count.txt').readAsString();
      print(file);

      setState(() {
        _count = int.parse(file);
      });

    }catch(e){
      print(e.toString());
    }
  }


  void writeCountFile(int count) async {
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path + '/count.txt').writeAsStringSync(count.toString());
  }

}