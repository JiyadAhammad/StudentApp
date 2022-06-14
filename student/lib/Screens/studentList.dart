import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student/database/dbfunction/functions.dart';
import 'package:student/database/dbfunction/updateStudent.dart';
import 'package:student/database/model/datamodel.dart';

class eachStudentListView extends StatefulWidget {
  final index;
  eachStudentListView({Key? key, required this.index}) : super(key: key);

  @override
  State<eachStudentListView> createState() => _eachStudentListViewState();
}

class _eachStudentListViewState extends State<eachStudentListView> {
  Widget dividerstyle = const Divider(
    color: Colors.grey,
    thickness: 2,
    indent: 30,
    endIndent: 30,
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifer,
        builder:
            (BuildContext ctx, List<StudentModel> studentlist, Widget? child) {
          final data = studentlist[this.widget.index];
          return Scaffold(
            appBar: AppBar(
              title: Text('Details'),
              actions: [
                IconButton(
                    onPressed: () {
                        updateStudent(context, this.widget.index);
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                      child: CircleAvatar(
                    backgroundImage: FileImage(File(data.image)),
                    radius: 100,
                  )),
                  Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      display("Name:", data.name.toUpperCase()),
                      dividerstyle,
                      display("Age:", data.age),
                      dividerstyle,
                      display("Course:", data.course),
                      dividerstyle,
                      display("Year:", data.year),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget display(field, data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          field,
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          data,
          style: TextStyle(fontSize: 25),
        )
      ],
    );
  }
}
