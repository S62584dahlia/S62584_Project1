/*
Matric Number: S62584
Program Name: Second Screen (implement MyCGPA screen)
*/

import 'package:flutter/material.dart';
import 'GPAManager.dart';
import 'screen3.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final GPAManager _gpaManager = GPAManager();    //manage GPA-related data
  double newGPA = 0.0;      //variable for new GPA

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(201, 192, 255, 1),
      appBar: AppBar(
        title: Text('MyCGPA'),
        backgroundColor: Color.fromRGBO(136, 115, 255, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _gpaManager.semesterData.length,
              itemBuilder: (context, index) {
                return _buildSemesterCard(index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showGPAInputDialog(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(69, 4, 180, 1),
              ),
              child: Text('Add Semester GPA'),
            ),
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total CGPA: ${_gpaManager.calculateCGPA().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSemesterCard(int index) {        //build card for display semester information
    return _gpaManager.semesterData.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.school),
                title: Text('Semester ${index + 1}'),
                subtitle: Text(
                    'GPA: ${_gpaManager.semesterData[index].gpa.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showEditDialog(
                          context,
                          index + 1,
                          _gpaManager.getSemesterGPAByIndex(index),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteConfirmationDialog(index);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  _navigateToScreen3(index + 1);
                },
              ),
            ),
          )
        : Container();
  }

  void _showGPAInputDialog(BuildContext context) {  // show dialog for enter new GPA
    double editedGPA = 0.0;
    TextEditingController _gpaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter GPA'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _gpaController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  editedGPA = double.tryParse(value) ?? 0.0;
                },
                decoration: InputDecoration(
                  labelText: 'Enter GPA',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _gpaManager.addSemesterGPA(editedGPA, []);
                  Navigator.pop(context);
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(69, 4, 180, 1),
                ),
                child: Text('Add Semester GPA'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int index) {   //show confirmation dialog for deleting semester
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Semester'),
          content: Text('Are you sure you want to delete this semester?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _gpaManager.removeSemesterGPA(index);
                Navigator.pop(context);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, int semesterIndex, double currentGPA) { //show dialog for editing GPA
    double editedGPA = currentGPA;
    TextEditingController _editController =
        TextEditingController(text: currentGPA.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit GPA - Semester $semesterIndex'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  editedGPA = double.tryParse(value) ?? 0.0;
                },
                decoration: InputDecoration(
                  labelText: 'Enter GPA',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _gpaManager.updateSemesterGPA(semesterIndex - 1, editedGPA);
                  Navigator.pop(context);
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFA80404),
                ),
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToScreen3(int semesterIndex) {   //navigate to screen3, passes information about specific semester
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Screen3(
          semesterIndex: semesterIndex,
          semesterGPA: _gpaManager.semesterData[semesterIndex - 1].gpa,
        ),
      ),
    ).then((value) {
      // Access and call the reloadCourses method
       Screen3.of(context)?.reloadCourses();
    });
  }
}
