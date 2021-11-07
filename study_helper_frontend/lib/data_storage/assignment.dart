import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'course.dart';

class Assignment {
  String name = "";
  Course course = Course();
  String type = "";
  DateTime dueTime = DateTime(2000);
  final DateFormat formatter = DateFormat('MM-dd-yy');

  Assignment({name, course, type, dueTime});

  static Assignment loadJson(String json) {
    var decodedJson = jsonDecode(json);
    return Assignment(
        name: decodedJson["name"],
        course: decodedJson["course"],
        type: decodedJson["type"],
        dueTime: DateTime.parse(decodedJson["dueTime"]));
  }

  String toJson() {
    return jsonEncode({
      "name": name,
      "course": course.toJson(),
      "type": type,
      "dueTime": dueTime.toIso8601String()
    });
  }

  Widget buildTitle(BuildContext context) => Text(name);

  Widget buildSubtitle(BuildContext context) =>
      Text(course.name + " " + type + " " + formatter.format(dueTime));
}
