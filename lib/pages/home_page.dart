import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/models/task_model.dart';
import 'package:note_app/pages/task_editor.dart';
import 'package:note_app/widgets/my_list_tile.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: netflixBlack,
        title: Text("My Habit App",style: TextStyle(color: netflixRed),),
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>('tasks').listenable(),
        builder: (context,box,_){
          return Padding(padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's Task",style: TextStyle(color: Colors.amber,fontSize: 26,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(formatDate(DateTime.now(), [d,', ',M," ",yyyy]),style: TextStyle(color: Colors.grey.shade700,fontSize: 18),),
              Divider(height: 40,thickness: 1,),
              Expanded(child: ListView.builder(
                itemCount: box.values.length,
                  itemBuilder: (context,index){
                  Task currentTask = box.getAt(index)!;
                  return MyListTile(index, currentTask);

              }))
            ],
          ),
          );
        },

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: netflixRed,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TaskEditor() ));
        },
        child: const Icon(
            CupertinoIcons.add,color: netflixBlack,),
      ),

    );
  }
}
