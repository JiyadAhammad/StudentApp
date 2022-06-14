import 'package:flutter/material.dart';
import 'package:student/Screens/adddetail.dart';
import 'package:student/database/dbfunction/functions.dart';


class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
       backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Student Details'),
        
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Click to Add Student",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xffF02E65)
                  ),
                ),
              ),
              ElevatedButton.icon(
                label: Text('Add Students'),
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (contxt) => studentDetails()));
                },
              )
            ]),
      ),
    );
  }
}
