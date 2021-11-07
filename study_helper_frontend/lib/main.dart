import 'package:flutter/material.dart';
import 'assignment_list.dart';
import 'package:get_storage/get_storage.dart';
import 'data_storage/application_data.dart';

class StaticApplicationData {
  static ApplicationData data =
      ApplicationData(courses: [], assignments: [], lastEdit: DateTime(2000));
}

void main() async {
  await GetStorage.init();

  if (GetStorage().hasData('data')) {
    StaticApplicationData.data =
        ApplicationData.loadJson(GetStorage().read('data'));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Helper',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const AssignmentPage(title: 'Homework'),
      debugShowCheckedModeBanner: false,
    );
  }
}
