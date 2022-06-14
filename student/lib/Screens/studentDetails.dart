

import 'package:flutter/material.dart';

import 'package:student/Screens/accountscreen.dart';
import 'package:student/Screens/homescreen.dart';


class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int currentSelectIndex = 0;

  List pages = [
    homeScreen(),
    accountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentSelectIndex,
        onTap: (newIndex) {
          setState(() {
            currentSelectIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Account'),
        ],
      ),
    );
  }

 
}
