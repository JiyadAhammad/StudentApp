import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student/database/model/datamodel.dart';



ValueNotifier<List<StudentModel>> studentListNotifer = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final id = await studentDB.add(value);
  value.key = id;
  studentListNotifer.value.add(value);
  // studentDB.putAt(index, value);

  studentListNotifer.notifyListeners();
}


Future<void> getAllStudents() async{
 final studentDB = await Hive.openBox<StudentModel>('student_db');
 studentListNotifer.value.clear();

 studentListNotifer.value.addAll(studentDB.values);
 studentListNotifer.notifyListeners();
}

// Future<void> deleteStudent(int key) async{
//   final studentDB = await Hive.openBox<StudentModel>('student_db');
//   await studentDB.delete(key);
//   getAllStudents();
// }

Future<void> deleteStudent(int id) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  final key = studentDb.keys;
  final saved_key = key.elementAt(id);
  await studentDb.delete(saved_key);
  getAllStudents();
}

Future<void> updated(StudentModel values, int id) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  final key = studentDb.keys;
  final saved_key = key.elementAt(id);
  await studentDb.put(saved_key, values);
  studentListNotifer.notifyListeners();
  getAllStudents();
}


