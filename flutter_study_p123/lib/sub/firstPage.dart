import 'package:flutter/material.dart';
import 'package:flutter_study_p123/animalItem.dart';

class FirstApp extends StatelessWidget {
  final List < Animal > ? list;
  const FirstApp({
    Key ? key,
    this.list
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(itemBuilder: (context, position) {
              /* itemBuilder는 BuildContext와 int를 반환
                BuildContext: 위젯의 위치
                int: 순번
              */
              return GestureDetector(
                child: Card(
                  child: Row(
                    children: [
                      Image.asset(
                        list![position].imagePath!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                      Text(list![position].animalName!)
                    ],
                  ),
                ),
                onTap: (){
                  AlertDialog dialog = AlertDialog(
                    content: Text(
                      '이 차량은 ${list![position].kind}입니다.',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  );
                  showDialog(context: context, builder: (BuildContext context) => dialog
                  );
                },
              );


            },
            itemCount: list!.length
            /* 아이템 개수만큼만 스크롤 할 수 있도록 제한 */
          )
        ),
      )
    );
  }
}