import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student/Screens/splash.dart';
import 'package:student/database/model/datamodel.dart';


Future<void> main() async{
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(StudentModelAdapter().typeId)){
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: SpalshScreen(),
    );
  }
}
