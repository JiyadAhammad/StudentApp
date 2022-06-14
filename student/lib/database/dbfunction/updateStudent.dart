

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/database/dbfunction/functions.dart';
import 'package:student/database/model/datamodel.dart';

final updateNameController = TextEditingController();
final updateAgeController = TextEditingController();
final updateCourseController = TextEditingController();
final updateYearController = TextEditingController();
ImagePicker imagePicker = ImagePicker();
var image;
Future<void> updateStudent(BuildContext context, int index) async {
  updateNameController.text = studentListNotifer.value[index].name;
  updateAgeController.text = studentListNotifer.value[index].age;
  updateCourseController.text = studentListNotifer.value[index].course;
  updateYearController.text = studentListNotifer.value[index].year;

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('Update Student Details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {},
                  controller: updateNameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  onChanged: (value) {},
                  controller: updateAgeController,
                  decoration: InputDecoration(hintText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  onChanged: (value) {},
                  controller: updateCourseController,
                  decoration: InputDecoration(hintText: 'Course'),
                ),
                TextField(
                  onChanged: (value) {},
                  controller: updateYearController,
                  decoration: InputDecoration(hintText: 'Year'),
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                        onPressed: () async {
                          XFile? img = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (img == null) {
                            image = studentListNotifer.value[index].image;
                          } else {
                            image = img.path;
                          }
                        },
                        icon: Icon(Icons.image),
                        label: Text('Image')),
                        SizedBox(
                          width: 20,
                        ),
                    ElevatedButton.icon(
                        onPressed: () {
                          onUpdateButtonClicked(index, context);
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.done),
                        label: Text('submit')),
                  ],
                )
              ],
            ));
      });
}

Future<void> onUpdateButtonClicked(int index, context) async {
  final updateName = updateNameController.text.trim();
  final updateAge = updateAgeController.text.trim();
  final updateCourse = updateCourseController.text.trim();
  final updateYear = updateYearController.text.trim();
  if (updateName.isEmpty ||
      updateAge.isEmpty ||
      updateCourse.isEmpty ||
      updateYear.isEmpty) {
    return;
  } else {
    final values = StudentModel(
        name: updateName,
        age: updateAge,
        course: updateCourse,
        year: updateYear,
        image: image);
       updated(values, index);
  }
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
      content: Text('updated')));
}



