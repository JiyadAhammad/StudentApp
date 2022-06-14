
import 'package:hive/hive.dart';
part 'datamodel.g.dart';

@HiveType(typeId: 1)
class StudentModel{


  @HiveField(0)
  int? key;


  @HiveField(1)
  final String image;
   
  @HiveField(2)
  final String name;

  @HiveField(3)
  final String age;

  @HiveField(4)
  final String course;

  @HiveField(5)
  final String year;

  StudentModel(
    {
      required this.image,
      required this.name,
      required this.age,
      required this.course,
      required this.year,
      
      this.key});
}
