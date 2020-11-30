
import 'package:flutter/material.dart';
import 'package:to_do_list/Todo.dart';
import './SecondView.dart';
import 'package:provider/provider.dart';
import './Mystate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'InternetFetcher.dart';


void main() {
  var state = Mystate();
  runApp(
    ChangeNotifierProvider(create:(context) => state,
    child:MyApp(),)
    );
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO_LIST',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyCustomForm(),
     
       
    );
  }
}


class MyCustomForm extends StatefulWidget {
  
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}


class _MyCustomFormState extends State<MyCustomForm> {
  
  final myController = TextEditingController();
  var filterby = 'all';
   
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  void initState(){
    super.initState();
    Provider.of<Mystate>(context,listen: false).setList();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Todo list '),
         actions: [PopupMenuButton(
           onSelected:(value){
            
            Provider.of<Mystate>(context,listen: false).setfilterlistBy(value);
           },
           itemBuilder: (context)=>[
           PopupMenuItem(child: Text('All'),value:'all'),
           PopupMenuItem(child: Text('Done '),value: 'Done'),
           PopupMenuItem(child: Text('remaining'),value:'remaining'),
         ]),
           IconButton(icon: Icon( Icons.arrow_right), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder:(context) => SecondView()));
           })
         ], 
      ),
      body: MyList(),
      
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: TextField(decoration: new InputDecoration(hintText:'Write your Todo here and press "+" to add'),
          controller: myController, 
        ),  
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Mystate state = Provider.of<Mystate>(context,listen: false);
          state.addItem(myController.text);
      },child: Icon(Icons.add),
      ),

      
    );
    
  }
}



class MyList extends StatelessWidget{


  Widget build(BuildContext context){
    return Consumer<Mystate>(builder: (context,state,child)=>
           ListView.builder(itemBuilder: (context,index) =>
           _item(context,state.list[index],index,state),  
      itemCount: state.list.length,
      ),
    );
  }

 
  Widget _item(context,item,index,state ){
    
     return 
     CheckboxListTile(controlAffinity:ListTileControlAffinity.leading,activeColor: Colors.blue,
      value: state.getCheckBox(index),
       onChanged: (bool newValue){
         state.setCheckBox(index,newValue,state.list[index]);
        

      },
      title:Text(state.list[index].text),
      secondary: IconButton(onPressed: (){
        
      Provider.of<Mystate>(context,listen: false).removeItem(index,state.list[index]);
    },
      icon: Icon(Icons.delete)) ,
      );

    
  }
}

