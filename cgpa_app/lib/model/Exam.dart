/*
Matric Number: S62584
Program Name: exam class (hold for exam details)
*/

import 'package:flutter/material.dart';

class Exam {
  String course;
  DateTime date;
  TimeOfDay time;
  String venue;

  Exam({
    required this.course,
    required this.date,
    required this.time,
    required this.venue,
  });
}