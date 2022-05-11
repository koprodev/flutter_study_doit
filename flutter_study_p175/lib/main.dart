import 'package:flutter/material.dart';
import 'package:http/http.dart'
as http; /* HTTP 통신 */
import 'dart:convert'; /* JSON 데이터 처리 */

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key ? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HttpApp(),
    );
  }
}



class HttpApp extends StatefulWidget {
  const HttpApp({
    Key ? key
  }): super(key: key);

  @override
  State < HttpApp > createState() => _HttpApp();
}

class _HttpApp extends State < HttpApp > {
  String result = '';
  List ? data; /* 결과 값을 리스트에 담기위해 */
  TextEditingController? _editingController; /* 검색어 입력 */
  ScrollController? _scrollController; /* 스크롤 마지막에 다음 페이지 불러오는 기능 용도 */
  int page = 1;


  @override
  void initState() {
    super.initState();
    data = List.empty(growable: true);
    _editingController = TextEditingController();
    _scrollController = ScrollController();


    _scrollController!.addListener(() {
      if(_scrollController!.offset >= _scrollController!.position.maxScrollExtent
         && !_scrollController!.position.outOfRange) {
        print('bottom');
        page ++;
        print('$page 번째 페이지 입니다');
        getJSONData();
      }
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력하세요'),

        ),
      ),
     body: Container(
        child: Center(
          child: data!.length == 0
              ? Text(
                  '데이터가 존재하지 않습니다.\n검색해주세요',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    //print(data![index]['thumbnail']);
                    return Card(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            if(data?[index]['thumbnail'] != '')
                            Image.network(
                              data![index]['thumbnail'],
                              height: 100,
                              width: 100,
                              fit: BoxFit.contain,
                            ) else Container(  height: 100,
                              width: 100,),
                            Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 150,
                                  child: Text(
                                    data![index]['title'].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                    '저자 : ${data![index]['authors'].toString()}'),
                                Text(
                                    '가격 : ${data![index]['sale_price'].toString()}'),
                                Text(
                                    '판매중 : ${data![index]['status'].toString()}'),
                              ],
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                      ),
                    );
                  },
                  itemCount: data!.length,
                  controller: _scrollController,

                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /* 떠있는 버튼(움직이지는 않음) */
        onPressed: () {
          getJSONData();
        },
        child: Icon(Icons.file_download),
      ),


    );
  }

  /*
    Future는 비동기 처리에서 데이터를 바로 처리할 수 없을때 사용
    Future<String> 없어도 동작은 하더라?
   */
  Future<String> getJSONData() async {
    var _keyWord = _editingController!.value.text;
    if(_keyWord ==''){
      print('_keyWord 가 없습니다.');
      return '';
    }
    //var url = 'https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=${_editingController!.value.text}';
    var url = 'https://dapi.kakao.com/v3/search/book?target=title&query=${_editingController!.value.text}&page=$page';
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization": "KakaoAK "
    });


    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      data!.addAll(result);

    });
    return response.body;
  }

}