import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:to_do_list/Todo.dart';


const API_KEY = 'ebb8aec0-d8d6-42c9-a383-a2db4038876e';
const API_URL = 'https://todoapp-api-vldfm.ondigitalocean.app/todos?key=';


class InternetFetcher{
  

  static getTitle() async{
    http.Response response = await http.get('$API_URL$API_KEY');
    //var jSondata = response.body;
    //var obj = jsonDecode(jSondata);

      Iterable l = json.decode(response.body);
     //Todo.fromJson(jsonDecode(response.body));

    List<Todo> todoList =
          (l as List).map((e) => Todo.fromJson(e)).toList();
          return todoList;
  }

static  postTodo(todo) async{
    //http.Response response = await http.post('$API_URL/$API_KEY',body:{'title':'apa','done':true} );
     http.Response response = await http.post('https://todoapp-api-vldfm.ondigitalocean.app/todos?key=$API_KEY',
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{'title': todo.text, "done": todo.value}));
       var jSondata = response.body;
       var obj = jsonDecode(jSondata);
     // return obj['id'];
    
    //var jSondata = response.body;
    //var obj = jsonDecode(jSondata);
    //return obj['title'];
  }
static Future<String>putTodo(todo) async{
  var id = todo.id;
  print(id);
    http.Response response = await http.put('https://todoapp-api-vldfm.ondigitalocean.app/todos/:$id?key=$API_KEY'
    ,headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{'title': todo.text, "done": todo.value}));
     
  }
static Future<String>deleteTodo() async{
    http.Response response = await http.delete('https://todoapp-api-vldfm.ondigitalocean.app/');
    var jSondata = response.body;
    var obj = jsonDecode(jSondata);
    return obj['title'];
  }


}