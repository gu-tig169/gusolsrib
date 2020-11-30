

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'Mystate.dart';



class SecondView extends StatelessWidget {
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('To Be Continued'),backgroundColor: Colors.blue ),
      body:
      Center(child: Consumer<Mystate>(builder: (context,state,child)=>MyList()
      
    )
    ),//floatingActionButton: _fab(context),
    );
  }
}
Widget _fab(context){
  return FloatingActionButton(
    onPressed: (){
      Mystate state = Provider.of<Mystate>(context,listen: false);
      state.addItem('new element');
      
    },
  child: Icon(Icons.add)
  );
  
}