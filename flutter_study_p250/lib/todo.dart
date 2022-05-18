
class Todo {
  String? title;
  String? content;
  int? active;
  int? id;

  Todo({this.title, this.content, this.active, this.id});

  // sqflite 패키지는 데이터를 Map 형태로 다룸
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'content' : content,
      'active' : active,
    };
  }
}