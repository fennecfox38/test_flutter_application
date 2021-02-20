import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo{
  bool isDone = false;
  String title;
  ToDo(this.title,{this.isDone=false});
}

class ToDoPage extends StatefulWidget {
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  TextEditingController _controller = TextEditingController(text: ' ');
  CollectionReference collection = FirebaseFirestore.instance.collection('ToDo');

  @override void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row( children: [ Expanded(child: TextField(controller: _controller,)),
              RaisedButton( child: Text('Add'), onPressed: ()=>_addToDo(ToDo(_controller.text)), ),
            ], ),
          StreamBuilder<QuerySnapshot>(
            stream: collection.snapshots(),
            builder: (context, stream) {
              if(!stream.hasData) return CircularProgressIndicator();
              QuerySnapshot querySnapshot = stream.data;
              return Expanded( child: ListView(children: querySnapshot.docs.map((e) => _getTile(e)).toList(),), );
            }
          ),
        ],
      ),
    );
  }

  Widget _getTile(DocumentSnapshot doc){
    final _toDo = ToDo(doc.get('title'),isDone: doc.get('isDone'));
    return ListTile(
      onTap: ()=> _toggleToDo(doc),
      title: Text(_toDo.title, style: (!_toDo.isDone?  TextStyle() :
      TextStyle(decoration: TextDecoration.lineThrough, fontStyle: FontStyle.italic, color: Colors.grey,) ), ),
      trailing: IconButton(icon: Icon(Icons.delete_forever), onPressed: ()=>_deleteToDo(doc),),
    );
  }

  void _addToDo(ToDo _toDo){
    collection.add({'title':_toDo.title,'isDone':_toDo.isDone});
    _controller.text='';
  }
  void _toggleToDo(DocumentSnapshot _doc){
    collection.doc(_doc.id).update({'isDone':!_doc.data()['isDone']});
  }
  void _deleteToDo(DocumentSnapshot _doc){
    collection.doc(_doc.id).delete();
  }

}
