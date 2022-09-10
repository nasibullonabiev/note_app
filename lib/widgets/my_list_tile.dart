import 'package:flutter/material.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/models/task_model.dart';
import 'package:note_app/pages/task_editor.dart';

class MyListTile extends StatefulWidget {
   MyListTile(this.index,this.task,{Key? key}) : super(key: key);
  Task task;
  int index;


  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: royal,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.task.title!,style: TextStyle(color: gold,fontWeight: FontWeight.bold,fontSize: 18),)),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>TaskEditor(task: widget.task,)));
              }, icon: Icon(Icons.edit,color: Colors.green,)),
              IconButton(onPressed: (){
                widget.task.delete();
              }, icon: Icon(Icons.delete,color: Colors.red,))
            ],
          ),
          Divider(color: Colors.orange,height: 20,thickness: 1,),
          Text(widget.task.note!,style: TextStyle(color: Colors.white,fontSize: 16),)
        ],
      ),
    );
  }
}
