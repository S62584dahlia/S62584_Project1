/*
Matric Number: S62584
Program Name: Main.dart (implement routes for screen navigation)
*/

import 'package:flutter/material.dart';
import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';
import 'screen4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CGPA App',
      initialRoute: '/first',
      routes: {
        '/first': (context) => Screen1(),
        '/second': (context) => Screen2(),
        '/third': (context) => Screen3(semesterIndex: 1, semesterGPA: 1,), //the values passed to the constructor of the Screen3 widget//initial parameters
        '/fourth': (context) => Screen4(),
      },
    );
  }
}
