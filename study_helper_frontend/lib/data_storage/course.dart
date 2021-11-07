import 'dart:convert';
import 'package:flutter/material.dart';

class Course {
  String name;

  Course({this.name = ""});

  static Course loadJson(String json) {
    return Course(name: jsonDecode(json)["name"]);
  }

  String toJson() {
    return jsonEncode({"name": name});
  }

  Widget buildTitle(BuildContext context) => Text(name);

  Widget buildSubtitle(BuildContext context) => const Text("");
}
