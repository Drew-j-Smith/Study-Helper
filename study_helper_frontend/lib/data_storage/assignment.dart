import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'course.dart';

class Assignment {
  String name;
  Course course;
  String type;
  DateTime date;
  final DateFormat formatter = DateFormat('MM-dd-yy');

  Assignment(
      {this.name = "",
      required this.course,
      this.type = "",
      required this.date});

  static Assignment loadJson(String json) {
    var decodedJson = jsonDecode(json);
    return Assignment(
        name: decodedJson["name"],
        course: Course.loadJson(decodedJson["course"]),
        type: decodedJson["type"],
        date: DateTime.parse(decodedJson["date"]));
  }

  String toJson() {
    return jsonEncode({
      "name": name,
      "course": course.toJson(),
      "type": type,
      "date": date.toIso8601String()
    });
  }

  Widget buildTitle(BuildContext context) => Text(name);

  Widget buildSubtitle(BuildContext context) =>
      Text(course.name + " " + type + " " + formatter.format(date));
}
