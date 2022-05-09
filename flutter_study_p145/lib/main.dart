import 'package:flutter/material.dart';
import 'animalItem.dart';
import 'sub/firstPage.dart';
import 'sub/secondPage.dart';
import './cupertinoMain.dart';

main() {
  runApp(CupertinoMain());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key ? key
  }): super(key: key);

  @override
  State < MyHomePage > createState() => _MyHomePageState();
}

class _MyHomePageState extends State < MyHomePage > with SingleTickerProviderStateMixin {
  /* with: 여러 클래스를 같이 재사용 가능하게 하는 키워드*/

  TabController ? controller;
  List<Animal> animalList = List.empty(growable: true); // 처음에는 빈 값이므로
  /* growable : 리스트가 가변적으로 증가할 수 있다는 의미 */

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    animalList.add(Animal(imagePath: 'repo/images/car01.png', animalName: '차이름01', kind: '블랙'));
    animalList.add(Animal(imagePath: 'repo/images/car02.png', animalName: '차이름02', kind: '블루'));
    animalList.add(Animal(imagePath: 'repo/images/car03.png', animalName: '차이름03', kind: '레드'));
    animalList.add(Animal(imagePath: 'repo/images/car04.png', animalName: '차이름04', kind: '실버'));
    animalList.add(Animal(imagePath: 'repo/images/car05.png', animalName: '차이름05', kind: '레드'));
    animalList.add(Animal(imagePath: 'repo/images/car06.png', animalName: '차이름06', kind: '블랙'));
    animalList.add(Animal(imagePath: 'repo/images/car07.png', animalName: '차이름07', kind: '실버'));
    animalList.add(Animal(imagePath: 'repo/images/car08.png', animalName: '차이름08', kind: '블랙'));
    animalList.add(Animal(imagePath: 'repo/images/car09.png', animalName: '차이름09', kind: '블루'));
    animalList.add(Animal(imagePath: 'repo/images/car10.png', animalName: '차이름10', kind: '블랙'));


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView 학습'),
        ),
        body: TabBarView(
          children: < Widget > [
            FirstApp(list: animalList), // 목록 전달
            SecondApp(list: animalList)
            ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.looks_one, color: Colors.blue)),
            Tab(icon: Icon(Icons.looks_two, color: Colors.blue)),
          ],
          controller: controller,
        ),
      ),
    );

  }


  /* 탭 컨트롤러는 애니메이션을 이용하므로 dispose() 함수를 호출해 주어야 메모리 누수를 막을 수 있음 */
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}