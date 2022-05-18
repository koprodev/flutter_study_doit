import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'todo.dart';
import 'addTodo.dart';
import 'clearList.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => DatabaseApp(database),
        '/add' : (context) => AddTodoApp(database),
        '/clear' : (context) => ClearListApp(database),
      },
      //home: DatabaseApp(),
    );
  }


  /*
  initDatabase() : 데이터베이스를 열어서 반환
  getDatabasesPath() : 함수가 반환하는 경로에 todo_database.db 라는 파일로 저장되어 있으며 이 파일을 불러와서 반환
  todo_database.db 파일에 테이블이 없으면 onCreate에서 새로운 데이터베이스 테이블을 생성
  */
  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title TEXT, content TEXT, active INTEGER)",
        );
      },
      version: 1,
    );
  }


}

class DatabaseApp extends StatefulWidget {

  final Future<Database> db;
  DatabaseApp(this.db);


  @override
  State<DatabaseApp> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {

  // Page.262
  Future<List<Todo>>? todoList;

  @override
  void initState(){
    super.initState();
    todoList = getTodos();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('SQL 테스트'),
        actions: [
          TextButton(
            onPressed: () async{
              await Navigator.of(context).pushNamed('/clear');
              setState(() {
                todoList = getTodos();
              });
            },
            child: Text('true',style: TextStyle(color:Colors.white),))
        ],


      ),
      body: Container(
        // Page.262
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


                        /*
                        return Card(
                          child: Column(
                            children: [
                              Text(todo.title!),
                              Text(todo.content!),
                              Text('${todo.active == 1 ? 'true' : 'false'}'),
                            ],
                          ),
                        );
                        */


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
                          onTap: () async {

                            // Page.268
                            TextEditingController controller = TextEditingController(text: todo.content);

                            Todo result = await showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('${todo.id} : ${todo.title}'),
                                /*
                                  content: Text('Todo를 체크하시겠습니까?'),
                                 */
                                  content: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.text,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        /*
                                        setState(() {
                                          todo.active == 1 ? todo.active = 0 : todo.active = 1;
                                        });
                                         */

                                        todo.active == 1 ? todo.active = 0 : todo.active = 1;
                                        todo.content = controller.value.text;

                                        Navigator.of(context).pop(todo);
                                      },
                                      child: Text('예')
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(todo);
                                      },
                                      child: Text('아니요')
                                    ),

                                  ],
                                );
                              }
                            );
                            _updateTodo(result);
                          }, // onTap

                          // Page.270
                          // 길게 누르면 삭제 팝업
                          onLongPress: () async {
                            var result = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('${todo.id} : ${todo.title}'),
                                  content: Text('${todo.content}를 삭제하시겠습니까?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(todo);
                                      },
                                      child: Text('예')
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        //Navigator.of(context).pop();
                                        Navigator.pop(context);
                                      },
                                      child: Text('아니오')
                                    ),

                                  ],
                                );
                              }
                            );
                            if(result != null){
                              _deleteTodo(result);
                            }

                          },  // onLongPress

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

            future: todoList,
          ),
        ),
      ),
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            onPressed: () async {
              final todo = await Navigator.of(context).pushNamed('/add');
            if (todo != null) {
                _insertTodo(todo as Todo);
              }
            },
            heroTag: null,
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              _allUpdate();
            },
            heroTag: null,
            child: Icon(Icons.update),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      )


    );
  }


  void _insertTodo(Todo todo) async {
    final Database database = await widget.db;
    // widget.db : database 객체를 선언,
    // widget을 이용하여 State상위 StatefulWidget에 있는 db변수를 사용할 수 있음
    await database.insert('todos', todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
     /* conflictAlgorithm : 충돌발생 대비, 이미 있는 id라면 replace */

     setState(() {
       todoList = getTodos();
     });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );

     setState(() {
       todoList = getTodos();
     });
  }

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete(
      'todos',
      where: 'id=?',
      whereArgs: [todo.id]
    );

    setState(() {
      todoList = getTodos();
    });
  }


  void _allUpdate() async {
    final Database database = await widget.db;
    await database.rawUpdate('update todos set active=1 where active=0');
    setState(() {
      todoList = getTodos();
    });
  }


  // Page. 261
  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate(maps.length, (i) {
      int active = maps[i]['active'] == 1 ? 1 : 0;
      return Todo(
        title: maps[i]['title'].toString(),
        content: maps[i]['content'].toString(),
        active: active,
        id: maps[i]['id']
      );
    });

  }

}