import 'dart:convert';

class Course {
  String name = "";

  Course({name});

  static Course loadJson(String json) {
    return Course(name: jsonDecode(json)["name"]);
  }

  String toJson() {
    return jsonEncode({"name": name});
  }
}
