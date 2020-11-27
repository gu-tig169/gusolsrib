



class Todo {

String id;
String text;
bool value;

Todo({this.id, this.text, this.value});


String get getId => id;
String get gettext => text;
bool  get getValue => value;

void setID(id){
  this.id = id;
}

factory Todo.fromJson(Map<dynamic, dynamic> json) {
    return Todo(
      id: json['id'],
      text: json['title'],
      value: json['done'],
    );
  }

}