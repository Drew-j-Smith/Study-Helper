import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'login.dart';
import 'create_account.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

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

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  List<Assignment> _assignments = [
    Assignment(name: 'test', course: 'test', date: DateTime.now(), type: 'test')
  ];

  final box = GetStorage(); // list of maps stored here

  List storageList = [];

  void addAndStoreAssignment(Assignment assignment) {
    _assignments.add(assignment);

    final storageMap = {}; // temp map
    final index = _assignments.length; // unique map keys
    final nameKey = 'name$index';
    final courseKey = 'course$index';
    final dateKey = 'date$index';
    final typeKey = 'type$index';

    storageMap[nameKey] = assignment.name;
    storageMap[courseKey] = assignment.course;
    storageMap[dateKey] = assignment.date;
    storageMap[typeKey] = assignment.type;

    storageList.add(storageMap);
    box.write('assignments', storageList);
  }

  void restoreAssignments() {
    if (box.hasData('assignments')) {
      storageList = box.read('assignments');
      String nameKey, courseKey, dateKey, typeKey;

      for (int i = 0; i < storageList.length; i++) {
        final map = storageList[i];
        final index = i + 1;

        nameKey = 'name$index';
        courseKey = 'course$index';
        dateKey = 'date$index';
        typeKey = 'type$index';

        // recreate assignment object

        final assignment = Assignment(
            name: map[nameKey],
            course: map[courseKey],
            date: map[dateKey],
            type: map[typeKey]);

        _assignments.add(assignment);
      }
    }
  }

  void clearAssignments() {
    _assignments.clear();
    storageList.clear();
    box.erase();
  }

  @override
  void initState() {
    super.initState();
    restoreAssignments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(),
          ),
          TextButton(
            onPressed: () {
              final task = Assignment(
                  name: 'test',
                  course: 'test',
                  date: DateTime.now(),
                  type: 'test');

              addAndStoreAssignment(task);
            },
            child: Text('Add Assignments'),
          ),
          TextButton(
            onPressed: () {
              clearAssignments();
            },
            child: Text('Clear Assignments'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const CreateAccountPage(title: 'Create Account')));
        },
        tooltip: 'Add Homework',
        child: const Icon(Icons.add),
      ),
    );
  }
}

abstract class ListItem {
  // title line for list item
  Widget buildTitle(BuildContext context);

  // subtitle line - can put sub content for assignments?
  Widget buildSubtitle(BuildContext context);
}

class Assignment {
  final String name;
  final String course;
  final String type;

  final DateFormat formatter = DateFormat('MM-dd-yy');
  final DateTime date;

  Assignment(
      {required this.name,
      required this.course,
      required this.date,
      required this.type});
}
