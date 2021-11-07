import 'dart:convert';

import 'assignment.dart';
import 'course.dart';

class ApplicationData {
  List<Course> courses;
  List<Assignment> assignments;
  DateTime lastEdit;

  ApplicationData(
      {required this.courses,
      required this.assignments,
      required this.lastEdit});

  static ApplicationData loadJson(String json) {
    var decodedJson = jsonDecode(json);
    List<Course> courses = [];
    for (var s in decodedJson["courses"]) {
      courses.add(Course.loadJson(s.toString()));
    }

    List<Assignment> assignments = [];
    for (var s in decodedJson["assignments"]) {
      assignments.add(Assignment.loadJson(s.toString()));
    }

    return ApplicationData(
        courses: courses,
        assignments: assignments,
        lastEdit: DateTime.parse(decodedJson["lastEdit"]));
  }

  String toJson() {
    List<String> courseJson = [];
    for (Course c in courses) {
      courseJson.add(c.toJson());
    }
    List<String> assignmentJson = [];
    for (Assignment a in assignments) {
      assignmentJson.add(a.toJson());
    }
    return jsonEncode({
      "courses": courseJson,
      "assignments": assignmentJson,
      "lastEdit": lastEdit.toIso8601String()
    });
  }

  List<String> getCourseList() {
    List<String> courseList = [];
    for (Course c in courses) {
      courseList.add(c.name);
    }
    return courseList;
  }

  Course? findCourse(String name) {
    for (Course c in courses) {
      if (c.name == name) {
        return c;
      }
    }
    return null;
  }
}
