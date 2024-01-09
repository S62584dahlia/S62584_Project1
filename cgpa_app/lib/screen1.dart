/*
Matric Number: S62584
Program Name: First Screen (Home Screen)
*/


import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/img4.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'EZY - SCORE',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Grade Tracker & Calculator',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            // Buttons
            Container(
              padding: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/second');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 60),
                      primary: Color.fromRGBO(69, 4, 180, 1),
                    ),
                    child: Text(
                      'MyCGPA',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),

                  //ElevatedButton
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/fourth');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 60),
                      primary: Color.fromRGBO(69, 4, 180, 1),
                    ),
                    child: Text(
                      'MyCalendar',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
