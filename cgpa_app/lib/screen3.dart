/*
Matric Number: S62584
Program Name: Third Screen (Courses Screen)
*/

import 'package:flutter/material.dart';
import 'model/Course.dart';
import 'GPAManager.dart';

class Screen3 extends StatefulWidget {
  //to identify the semester and its GPA.
  final int semesterIndex;
  final double semesterGPA;

  static _Screen3State? of(BuildContext context) =>
      context.findAncestorStateOfType<_Screen3State>();  
  Screen3({
    required this.semesterIndex, 
    required this.semesterGPA
    });

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final GPAManager _gpaManager = GPAManager();
  late TextEditingController _courseNameController;
  late String _selectedGrade;
  late List<Course> _courses;

  @override
  void initState() {
    super.initState();
    // Load the courses for the selected semester from GPAManager
    _loadCourses();

    // Initialize controllers and variables
    _courseNameController = TextEditingController();
    _selectedGrade = '-1'; // Set a default grade
  }

  void _loadCourses() {
    // Retrieve the courses for the selected semester from GPAManager
    List<Course> storedCourses =
        _gpaManager.getCoursesForSemester(widget.semesterIndex);
    setState(() {
      _courses = storedCourses;
    });
  }


// add new course
  void _addCourse() {
    Course newCourse = Course(
      name: _courseNameController.text,
      grade: _selectedGrade,
    );
    setState(() {
      _courses.add(newCourse);
      _courseNameController.text = ''; // Clear the text field
      _selectedGrade = '-1'; // Reset to default grade
    });

    _gpaManager.setCoursesForSemester(widget.semesterIndex, _courses);
  }


//delete course
  void _deleteCourse(int index) {
    setState(() {
      _courses.removeAt(index);
    });

    _gpaManager.setCoursesForSemester(widget.semesterIndex, _courses);
  }

  // Expose a method to reload courses
  void reloadCourses() {
    _loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(190, 178, 255, 1),
      appBar: AppBar(
        title: Text('Courses - Semester ${widget.semesterIndex}'),
        backgroundColor: Color.fromRGBO(136, 115, 255, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text('Course: ${_courses[index].name}'),
                      subtitle: Text('Grade: ${_courses[index].grade}'),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Color.fromRGBO(185, 13, 0, 0.801),
                        ),
                        onPressed: () {
                          _deleteCourse(index);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showCourseInputDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(69, 4, 180, 1),
                  ),
                  child: Text('Add Course'),
                ),
              ],
            ),
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total GPA: ${widget.semesterGPA.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }


//to show dialog for adding new course
  void _showCourseInputDialog(BuildContext context) {
    TextEditingController _gradeController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Add Course'),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _courseNameController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText: 'Enter Course Name',
                      ),
                    ),
                    SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Grade:'),
                        DropdownButtonFormField(
                          items: [
                            DropdownMenuItem(
                              child: Text('-Select grade-'),
                              value: '-1',
                            ),
                            DropdownMenuItem(
                              child: Text('A'),
                              value: 'A',
                            ),
                            DropdownMenuItem(
                              child: Text('A-'),
                              value: 'A-',
                            ),
                            DropdownMenuItem(
                              child: Text('B+'),
                              value: 'B+',
                            ),
                            DropdownMenuItem(
                              child: Text('B'),
                              value: 'B',
                            ),
                            DropdownMenuItem(
                              child: Text('B-'),
                              value: 'B-',
                            ),
                            DropdownMenuItem(
                              child: Text('C'),
                              value: 'C',
                            ),
                            DropdownMenuItem(
                              child: Text('C-'),
                              value: 'C-',
                            ),
                            DropdownMenuItem(
                              child: Text('D'),
                              value: 'D',
                            ),
                            DropdownMenuItem(
                              child: Text('F'),
                              value: 'F',
                            ),
                          ],
                          value: _selectedGrade,
                          onChanged: (value) {
                            setState(() {
                              _selectedGrade = value.toString();
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _addCourse();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(69, 4, 180, 1),
                          ),
                          child: Text('Add Course'),
                        ),
                      ],
                    )
                  ]));
        });
  }
}
