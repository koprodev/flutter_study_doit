import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'todo.dart';


class ClearListApp extends StatefulWidget {
//  const ClearListApp({ Key? key }) : super(key: key);

  Future<Database> database;
  ClearListApp(this.database);

  @override
  State<ClearListApp> createState() => _ClearListApp();
}

class _ClearListApp extends State<ClearListApp> {

  Future<List<Todo>>? clearList;

  @override
  void initState(){
    super.initState();
    clearList = getClearList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('true 목록'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch(snapshot.connectionState){
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if(snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Todo todo = (snapshot.data as List<Todo>)[index];


                        return ListTile(
                          title: Text(
                            todo.title!,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Container(
                            child: Column(
                              children: [
                                Text(todo.content!),
                                Container(
                                  height: 1,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          trailing: Container(
                            child: Text('${todo.active == 1 ? 'true' : 'false'}'),
                          ),


                        );




                      },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  }else{
                    return Text('데이터가 없습니다');
                  }
              }
              return CircularProgressIndicator();
            },

            future: clearList,
          ),
        ),
      ),

      // 삭제버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('true 삭제'),
                content: Text('모두 삭제하시겠습니까?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('예')
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('아니요')
                  ),
                ],
              ); // AlertDialog
            }
          ); // showDialog
          if(result == true){
            _removeAllTodos();
          }
        },
        child: Icon(Icons.remove),
      ),

    );
  }


  void _removeAllTodos() async {
    final Database database = await widget.database;
    database.rawDelete('delete from todos where active=1');
    setState(() {
      clearList = getClearList();
    });
  }


  Future<List<Todo>> getClearList() async {

    final Database database = await widget.database;
    List<Map<String, dynamic>> maps = await database.rawQuery(
      'select title, content, active, id from todos where active=1'
    );

    return List.generate(maps.length, (index) {
      return Todo(
        title: maps[index]['title'].toString(),
        content: maps[index]['content'].toString(),
        active: maps[index]['active'],
        id: maps[index]['id']
      );
    });

  }

}