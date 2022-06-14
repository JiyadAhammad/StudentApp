import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student/Screens/studentList.dart';
import 'package:student/database/dbfunction/functions.dart';
import '../database/model/datamodel.dart';

class accountScreen extends StatefulWidget {
  const accountScreen({Key? key}) : super(key: key);

  @override
  State<accountScreen> createState() => _accountScreenState();
}

class _accountScreenState extends State<accountScreen> {
  bool searchicon = false;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
               showSearch(
                context: context,
                delegate: MySearch());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifer,
        builder: (BuildContext context, List<StudentModel> studentList,
            Widget? child) {
          return Card(
            elevation: 50.0,
            shadowColor: Colors.black,
            // color: Colors.greenAccent[100],
            child: ListView.separated(
              itemBuilder: (context, index) {
                final data = studentList[index];
                return Container(
                  height: 80,
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => eachStudentListView(index: index)),
                    ),
                    title: Text(data.name.toUpperCase()),
                    subtitle: Wrap(
                      children: [
                        Text(data.age),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.image.toString())),
                      radius: 30,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          showAlertDialog(context, index);
                        },
                        icon: Icon(Icons.delete),color: Colors.red,),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(thickness: 2,color: Colors.grey,);
              },
              itemCount: studentList.length,
            ),
          );
        },
      ),
    );
  }

  showAlertDialog(BuildContext contxt, int index) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget okButton = ElevatedButton(
      child: Text("Ok"),
      onPressed: () {
        deleteStudent(index);
        ScaffoldMessenger.of(contxt).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 49, 185, 11),
            margin: EdgeInsets.all(20),
            behavior: SnackBarBehavior.floating,
            content: Text("Item deleted Successfully"),
            duration: Duration(seconds: 2)));
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Do you Want to Delete ?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listItems = query.isEmpty
        ? studentListNotifer.value
        : studentListNotifer.value
            .where((element) => element.name
                .toLowerCase()
                .startsWith(query.toLowerCase().toString()))
            .toList();

    return listItems.isEmpty
        ? const Center(child: Text("No Data Found!"))
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 15.00, right: 15.00),
                  child: Column(
                    children: [
                      ListTile(
                        leading: getimage(listItems[index]),
                        title: Text(listItems[index].name),
                        subtitle: Text(
                            "Age : ${(listItems[index].age.toString())}"),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  eachStudentListView(index: index)));
                        },
                      ),
                      const Divider(thickness: 3,color: Colors.grey,),
                    ],
                  ));
            });
  }
  getimage(data) {
    if (data.image == null) {
      return const CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.png'),
      );
    } else {
      return CircleAvatar(
        backgroundImage: FileImage(File(data.image)),
      );
    }
  }
}
