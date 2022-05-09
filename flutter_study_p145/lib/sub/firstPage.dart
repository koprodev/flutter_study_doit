import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../animalItem.dart';

class FirstApp extends StatelessWidget {
  final List<Animal> list;
  const FirstApp({
    Key ? key,
    required this.list
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('자동차 리스트'),
      ),

          child: ListView.builder(itemBuilder: (context, position) {
              /* itemBuilder는 BuildContext와 int를 반환
                BuildContext: 위젯의 위치
                int: 순번
              */
              return Container(
                padding: EdgeInsets.all(5),
                height: 100,
                child: Column(
                  children: [Row(
                    children: [
                      Image.asset(
                        list[position].imagePath!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                      Text(list[position].animalName!)
                    ],
                  )],
                ),
              );


            },
            itemCount: list.length
            /* 아이템 개수만큼만 스크롤 할 수 있도록 제한 */
          )

    );
  }
}