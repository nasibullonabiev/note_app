import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/models/task_model.dart';
import 'package:note_app/pages/home_page.dart';
late Box box;
void main()async{
  await Hive.initFlutter();
   Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>('tasks');
  await box.add(Task(title: 'this is first Task',note: 'this is the first task made with the app',creation_date: DateTime.now()));



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
