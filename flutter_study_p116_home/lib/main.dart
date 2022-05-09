import 'package:flutter/material.dart';
import 'sub/firstPage.dart';
import 'sub/secondPage.dart';
import 'sub/thirdPage.dart';

main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  /* with: 여러 클래스를 같이 재사용 가능하게 하는 키워드*/

  TabController? myController;

  @override
  void initState() {
    super.initState();
    myController = TabController(length: 3, vsync: this);

    /* TabController 에서 제공하는 탭의 위치,애니메이션 상태 확인하여 기능 적용 가능 */
    myController?.addListener(() {
      print('이전 index: ${myController!.previousIndex}');
      print('현재 index: ${myController!.index}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: const Text('탭바 학습'),
          bottom: TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.looks_one, color: Colors.white)),
              Tab(icon: Icon(Icons.looks_two, color: Colors.white)),
              Tab(icon: Icon(Icons.looks_3, color: Colors.white)),
            ],
            controller: myController,
          )),
      body: TabBarView(
        children: const <Widget>[FirstApp(), SecondApp(), GrtechWebsiteGW()],
        controller: myController,
      ),
      bottomNavigationBar: TabBar(
        tabs: const [
          Tab(icon: Icon(Icons.looks_one, color: Colors.blue)),
          Tab(icon: Icon(Icons.looks_two, color: Colors.blue)),
          Tab(icon: Icon(Icons.looks_3, color: Colors.blue)),
        ],
        controller: myController,
      ),
    ));
  }

  /* 탭 컨트롤러는 애니메이션을 이용하므로 dispose() 함수를 호출해 주어야 메모리 누수를 막을 수 있음 */
  @override
  void dispose() {
    myController!.dispose();
    super.dispose();
  }
}
