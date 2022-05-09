import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({
    Key ? key
  }): super(key: key);

  static
  const String _title = 'Flutter Test'; // 컴파일 시 상수화

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: WidgetApp(),

    );
  }
}

class WidgetApp extends StatefulWidget {
  const WidgetApp({
    Key ? key
  }): super(key: key);

  @override
  State < WidgetApp > createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State < WidgetApp > {

  List _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  List < DropdownMenuItem < String >> _dropDownMenuItems = new List.empty(growable: true);
  String ? _buttonText; /* ?: null일 수 있음 */

  @override
  void initState() {
    super.initState();
    for (var item in _buttonList) {
      _dropDownMenuItems.add(DropdownMenuItem(
        value: item,
        child: Text(item)
      ));
    }
    _buttonText = _dropDownMenuItems[0].value;

  }


  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('플러터 학습 : 사칙연산'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('P104'),
                ),
                Padding(padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(keyboardType: TextInputType.number, controller: value1, ), /* keyboardType:사용자에게 보일 키보드 타입 */
                  /*
                  text 기본 텍스트
                  multiline 멀티 라인 텍스트. 메모 같이 여러 줄을 입력할 때 사용
                  number 숫자 키보드 표시
                  phone 전화번호 전용 키보드
                  datetime 날짜 입력 키보드
                  emailAddress @ 표시 등 이메일 입력 키보드
                  url 주소 입력 창 */
                ),
                Padding(padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(keyboardType: TextInputType.number, controller: value2, ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: DropdownButton(
                    items: _dropDownMenuItems,
                    onChanged: (String ? value) {
                      setState(() {
                        _buttonText = value;
                      });
                    }, value: _buttonText, ),
                ),
                Padding(padding: EdgeInsets.all(15),
                  child: ElevatedButton(
                    child: Row(children: [
                      Text(_buttonText!), /* ! : null 허용 안함 */
                      Icon(Icons.calculate),

                    ], ),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                    onPressed: () {
                      setState(() {
                        /* 위젯의 상태를 갱신, State클래스를 상속받은 클래스에서만 사용가능 */
                        int result1 = int.parse(value1.value.text);
                        int result2 = int.parse(value2.value.text);
                        var result;


                        switch (_buttonText) {
                          case '더하기':
                            result = result1 + result2;
                            break;
                          case '빼기':
                            result = result1 - result2;
                            break;
                          case '곱하기':
                            result = result1 * result2;
                            break;
                          case '나누기':
                            result = result1 / result2;
                            break;
                        }
                        /* 문자열을 정수로 변경 */
                        sum = '$result';

                      });
                    },
                  )
                ),
                Padding(padding: EdgeInsets.all(15),
                  child: Text(
                    '결과: $sum',
                    style: TextStyle(fontSize: 20),
                  )
                )
            ],
          ),
        )
      )
    );
  }
}