import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:to_do_list/Todo.dart';

// ;'cf792016-20bf-43be-a53b-0378adc60c39'
const API_KEY = '28194af2-37c6-4905-8e51-1e3180bf421c';
const API_URL = 'https://todoapp-api-vldfm.ondigitalocean.app/todos?key=';


class InternetFetcher{
  

  static getList() async{
    http.Response response = await http.get('$API_URL$API_KEY');
    //var jSondata = response.body;
    //var obj = jsonDecode(jSondata);

      Iterable l = json.decode(response.body);
     //Todo.fromJson(jsonDecode(response.body));

    List<Todo> todoList =
          (l as List).map((e) => Todo.fromJson(e)).toList();
          return todoList;
  }

static Future  postTodo(todo) async{
    //http.Response response = await http.post('$API_URL/$API_KEY',body:{'title':'apa','done':true} );
     http.Response response = await http.post('https://todoapp-api-vldfm.ondigitalocean.app/todos?key=$API_KEY',
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{'title': todo.text, "done": todo.value}));
       
     // return obj['id'];
    
    //var jSondata = response.body;
    //var obj = jsonDecode(jSondata);
    //return obj['title'];
  }
static Future<String>putTodo(todo) async{
  var id = todo.id;
  var body = jsonEncode(<String, dynamic>{'title': todo.text, "done": todo.value});
  print(id);
  //print(body);
    http.Response response = await http.put('https://todoapp-api-vldfm.ondigitalocean.app/todos/$id?key=$API_KEY'
    ,headers: <String, String>{"Content-Type": "application/json"},
        body: body);
        //print(response.body);
     
  }
static Future<String>deleteTodo(todo) async{
    var id = todo.id;
    print(id);
    var body = jsonEncode(<String, dynamic>{'title': todo.text, "done": todo.value});
    http.Response response = await http.delete('https://todoapp-api-vldfm.ondigitalocean.app/todos/$id?key=$API_KEY'
    ,headers: <String, String>{"Content-Type": "application/json"});
   // print(response);
   // var jSondata = response.body;
   // var obj = jsonDecode(jSondata);
   // return obj['title'];
  }


}