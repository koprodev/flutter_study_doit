import 'package:flutter/material.dart';
import '../animalItem.dart';

class SecondApp extends StatefulWidget {
  final List<Animal>? list;
  const SecondApp({Key? key, this.list}) : super(key: key);

  @override
  State<SecondApp> createState() => _SecondApp();
}

class _SecondApp extends State<SecondApp> {
  final nameController = TextEditingController();
  int? _radioValue = 1;
  bool? flyExist = false;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            Row(
              children: [
                Radio(
                    value: 0, groupValue: _radioValue, onChanged: _radioChange),
                /* value: 인덱스 값, groupValue: 선택 value 값, onChanged: 라디오 변경시 호출할 함수 */
                Text('블랙'),
                Radio(
                    value: 1, groupValue: _radioValue, onChanged: _radioChange),
                Text('레드'),
                Radio(
                    value: 2, groupValue: _radioValue, onChanged: _radioChange),
                Text('블루'),
              ],
            ),
            Row(
              children: [
                Text('빨간색 자동차인가요?'),
                Checkbox(
                  value: flyExist,
                  onChanged: (bool? check) {
                    setState(() {
                      flyExist = check;
                    });
                  },
                ),
              ],
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset('repo/images/car10.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/car10.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/car11.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/car11.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/car12.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/car12.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/car10.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/car10.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/car10.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/car10.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/car11.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/car11.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/car12.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/car12.png';
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
                child: Text('자동차 추가하기'),
                onPressed: () {
                  var animal = Animal(
                      imagePath: _imagePath,
                      animalName: nameController.value.text,
                      kind: getKind(_radioValue),
                      flyExist: flyExist);
                  AlertDialog dialog = AlertDialog(
                    title: Text('자동차 추가하기'),
                    content: Text(
                      '이 자동차는 ${animal.animalName} 입니다.',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            widget.list?.add(animal);
                            Navigator.of(context).pop();
                          },
                          child: Text('예')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('아니오')),
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                })
          ],
        )),
      ),
    );
  }

  _radioChange(int? value) {
    setState(() {
      _radioValue = value;
      print(_radioValue);
    });
  }

  getKind(int? radioValue) {
    switch(radioValue) {
      case 0 :
        return '블랙';
      break;
      case 1 :
        return '레드';
      break;
      case 2 :
        return '블루';
      break;
    }

  }
}
