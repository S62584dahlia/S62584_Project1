/*
Matric Number: S62584
Program Name: GPAManager class for managing GPA-related data (semester GPA & associated course)
*/

import 'model/Course.dart';

class GPAManager {
  static final GPAManager _instance = GPAManager._internal();

  factory GPAManager() {
    return _instance;
  }

  GPAManager._internal();   

//Maintains a list of GPAData objects, each representing the GPA and courses for a specific semester.
  List<GPAData> semesterData = [];

  void addSemesterGPA(double gpa, List<Course> courses) {  //add semester
    semesterData.add(GPAData(gpa: gpa, courses: courses));
  }

  void removeSemesterGPA(int index) {   //remove semester
    if (index >= 0 && index < semesterData.length) {
      semesterData.removeAt(index);
    }
  }

  void updateSemesterGPA(int index, double editedGPA) {  //update semester
    if (index >= 0 && index < semesterData.length) {
      semesterData[index].gpa = editedGPA;
    }
  }

   double getSemesterGPAByIndex(int index) {   //returns GPA of the semester at specific index
  if (index >= 0 && index < semesterData.length) {
    return semesterData[index].gpa;
  }
  return 0.0;
}

//calculate cumulative GPA (CGPA) based on GPA individual semester stored in semesterData list.
  double calculateCGPA() {
    if (semesterData.isEmpty) {   //no CGPA to calculate
      return 0.0;
    }

    double totalGPA = semesterData.map((data) => data.gpa)  //use map function to extract GPA from each GPAData object in list.
    .reduce((a, b) => a + b);    //sum up all the GPA
    return totalGPA / semesterData.length;  
  }


//method for get and set the list of courses for specific semester
  List<Course> getCoursesForSemester(int semesterIndex) {
    return semesterData.isNotEmpty && semesterIndex >= 0 && semesterIndex < semesterData.length
        ? semesterData[semesterIndex].courses
        : [];
  }

  void setCoursesForSemester(int semesterIndex, List<Course> courses) {
    if (semesterIndex >= 0 && semesterIndex < semesterData.length) {
      semesterData[semesterIndex].courses = courses;
    }
  }
}


//GPAData class, hold GPA and list of courses for that semester.
class GPAData {    
  double gpa;
  List<Course> courses;

  GPAData({
    required this.gpa, 
    required this.courses});
}
