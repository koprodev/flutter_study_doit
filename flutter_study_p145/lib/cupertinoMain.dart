import 'package:flutter/cupertino.dart';
import 'animalItem.dart';
import 'sub/firstPage.dart';

class CupertinoMain extends StatefulWidget {
  const CupertinoMain({ Key? key }) : super(key: key);

  @override
  State<CupertinoMain> createState() => _CupertinoMain();
}

class _CupertinoMain extends State<CupertinoMain> {
  CupertinoTabBar? tabBar;
  List<Animal> animalList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    tabBar = CupertinoTabBar(items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
    ]);

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
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: tabBar!,
        tabBuilder: (context, value) {
          if(value == 0){
            return FirstApp(
              list: animalList,
            );
          }else{
            return Container(
              child: Center(
                child: Text('애플 탭 2'),
              ),
            );
          }
        }
      ),

    );
  }
}