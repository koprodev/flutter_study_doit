import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class LargeFileMain extends StatefulWidget {
  const LargeFileMain({
    Key ? key
  }): super(key: key);

  @override
  State < LargeFileMain > createState() => _LargeFileMain();
}

class _LargeFileMain extends State < LargeFileMain > {

  final imgUrl =
  'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg'
  '?auto=compress';

  bool downloading = false;
  var progressString = "";
  String file = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('파일 내려받기 테스트'),
      ),
      body: Center(
        child: downloading ? // downloading == true : 파일을 내려받는 중
        Container(
          height: 120.0,
          width: 200.0,
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '파일 다운로드: $progressString',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ) :
        // downloading == false
        FutureBuilder(
          builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:  // FutureBuilder.future == null
                  print('none');
                  return Text('데이터 없음');

                case ConnectionState.waiting: // 연결되기 전
                  print('waiting');
                  return CircularProgressIndicator();

                case ConnectionState.active: // 하나 이상의 데이터를 반환받을 때
                  print('active');
                  return CircularProgressIndicator();

                case ConnectionState.done:  // 모든 데이터를 받고 연결이 끝날 때
                  print('done');
                  if (snapshot.hasData) {
                    return snapshot.data as Widget;
                  }
              }
              print('end progress');
              return Text('데이터 없음!');
            },
            future: downloadWidget(file),

        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }


  Future <void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      /* path_provider 패키지 : 플러터 앱 내부 디렉터리를 가져오는 역할 */
      await dio.download(imgUrl, '${dir.path}/myimage.jpg',
        /* url에 담긴 파일을 다운로드, 내부 디렉토리에 myimage.jpg로 저장 */
        onReceiveProgress: (rec, total) {
          /* 데이터를 받을 때마다 진행 상황 표시 */
          /* rec: 현재까지 내려받은 데이터 크기, total: 파일 전체 크기 */
          print('Rec: $rec, Total: $total');
          file = '${dir.path}/myimage.jpg';
          print(file);
          setState(() {
            downloading = true;
            progressString = ((rec / total) * 100).toStringAsFixed(0) + '%';
          });
        });


    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = '완료';
    });
    print('다운로드 완료');
  }


  Future downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict();  // 캐시 초기화 (캐시에 동일한 이미지 파일명이 있으면 재사용하므로 => 캐시 비움)

    if(exist){
      return Center(
        child: Column(
          children: [Image.file(File(filePath))],
        ),
      );
    }else{
      return Text('데이터 없음');
    }
  }

}