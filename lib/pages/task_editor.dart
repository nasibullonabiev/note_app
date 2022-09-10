import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/models/task_model.dart';
import 'package:note_app/pages/home_page.dart';


class TaskEditor extends StatefulWidget {
  Task? task;
   TaskEditor({this.task,Key? key}) : super(key: key);

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController(text: widget.task == null ? null : widget.task!.title!);
    TextEditingController _taskNote = TextEditingController(text: widget.task == null ? null : widget.task!.note!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: netflixBlack,
      iconTheme: IconThemeData(color: Colors.black),
        title: Text(widget.task == null ? 'Add a new Task' : "Update your task",style: TextStyle(color: netflixRed),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Task's Title",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: 12,),
            TextField(
              controller: _taskTitle,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(8)),
                hintText: "Your Task",
              ),
            ),

            SizedBox(height: 40,),

            Text("Your Task's Note",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: 12,),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 25,
              controller: _taskNote,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(8)),
                hintText: "Write some Notes",
              ),
            ),
            Expanded(child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height: 60,
                width: double.infinity,
                child: RawMaterialButton(onPressed: ()async{
                  var newTask = Task(
                    title: _taskTitle.text,
                    note: _taskNote.text,
                    creation_date: DateTime.now(),
                    done: false,
                  );
                  Box<Task>taskBox = Hive.box<Task>('tasks');
                  if(widget.task != null){
                    widget.task!.title = newTask.title;
                    widget.task!.note = newTask.note;
                    widget.task!.save();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }else{
                    await taskBox.add(newTask);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

                  }
                },fillColor: Colors.blueAccent,
                child: Text(widget.task == null ? "Add new Task":"Update Task",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ),

            ))
          ],
        ),
      ),

    );
  }
}
