/*
Matric Number: S62584
Program Name: MyCalendar Screen 
*/

import 'package:flutter/material.dart';
import 'model/Exam.dart';

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();

  Exam? _originalExam; // Store the original exam before modifications

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(201, 192, 255, 1),
      appBar: AppBar(
        title: Text('MyCalendar'),
        backgroundColor: Color.fromRGBO(136, 115, 255, 1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 32),
              Text(
                'Assessment Calendar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: Globals.exams.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(Icons.event_note_rounded),
                        title: Text('Course: ${Globals.exams[index].course}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.date_range),
                                SizedBox(width: 8),
                                Text('Date: ${_formatDate(Globals.exams[index].date)}'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(width: 8),
                                Text('Time: ${Globals.exams[index].time.format(context)}'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(width: 8),
                                Text('Venue: ${Globals.exams[index].venue}'),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            _showDeleteConfirmationDialog(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _showAddExamDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(69, 4, 180, 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text('Add New Exam'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Helper method to format the date as a string
  String _formatDate(DateTime date) {
   return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
  }

// Helper method to ensure two digits in a number
  String _twoDigits(int n) {
  if (n >= 10) return '$n';
  return '0$n';
}

 // Show the dialog to add a new exam
  void _showAddExamDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Reset controllers to original values or empty if no original values are available
        _courseController.text = _originalExam?.course ?? '';
        _dateController.text = _originalExam?.date != null ? _formatDate(_originalExam!.date) : '';
        _timeController.text = _originalExam?.time != null ? _originalExam!.time.format(context) : '';
        _venueController.text = _originalExam?.venue ?? '';

        return AlertDialog(
          title: Text('Add New Exam'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Input field for entering the course
                TextField(
                  controller: _courseController,
                  decoration: InputDecoration(
                    labelText: 'Enter Course',
                    prefixIcon: Icon(Icons.event),
                  ),
                ),
                SizedBox(height: 8),

                // Input field for selecting the date
                TextField(
                  controller: _dateController,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      _dateController.text = _formatDate(pickedDate);
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    prefixIcon: Icon(Icons.date_range),
                  ),
                ),
                SizedBox(height: 8),

                // Input field for selecting the time
                TextField(
                  controller: _timeController,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      _timeController.text = pickedTime.format(context);
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Time',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                ),
                SizedBox(height: 8),

                // Input field for entering the venue
                TextField(
                  controller: _venueController,
                  decoration: InputDecoration(
                    labelText: 'Enter Venue',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                addNewExam();
                Navigator.pop(context);
              },
              child: Text('Add Exam'),
            ),
          ],
        );
      },
    );
  }

// Show the dialog to confirm exam deletion
  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Exam'),
          content: Text('Are you sure you want to delete this exam?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteExam(index);
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

 // Add a new exam to the list
  void addNewExam() {
    String course = _courseController.text;
    DateTime date = DateTime.parse(_dateController.text); 
    TimeOfDay time = TimeOfDay.now();
    String venue = _venueController.text;

    Exam newExam = Exam(course: course, date: date, time: time, venue: venue);

    setState(() {
      Globals.exams.add(newExam);
      // Clear the input fields
      _courseController.clear();
      _dateController.clear();
      _timeController.clear();
      _venueController.clear();
    });
  }

// Delete an exam from the list
  void deleteExam(int index) {
    setState(() {
      Globals.exams.removeAt(index);
    });
  }
}

// A class to hold global data (list of exams)
class Globals {
  static List<Exam> exams = [];
}
