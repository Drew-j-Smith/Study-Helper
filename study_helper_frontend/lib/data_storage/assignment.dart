import 'dart:convert';

import 'course.dart';

class Assignment {
  String name = "";
  Course course = Course();
  String type = "";
  DateTime dueTime = DateTime(2000);

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
}
