import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'elements/drawer.dart';
import 'course_list.dart';
import 'create_assignment.dart';
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
  List<Assignment> _assignments = [];
  List<Course> _courses = [];
  DateTime lastEvent = DateTime.now();

  final box = GetStorage(); // list of maps stored here

  List storageList = [];

  dynamic getState() {
    return {
      "assignments": _assignments,
      "courses": _courses,
      "last_update": lastEvent
    };
  }

  void storeAndAddAssignment(Assignment assignment) {
    _assignments.add(assignment);

    final storageMap = {}; // temp map
    final index = _assignments.length; // unique map keys
    final nameKey = 'name$index';
    final courseKey = 'course$index';
    final dateKey = 'date$index';
    final typeKey = 'type$index';

    storageMap[nameKey] = assignment.name;
    storageMap[courseKey] = assignment.course;
    storageMap[dateKey] = DateFormat('yyyy-MM-dd').format(assignment.date);
    storageMap[typeKey] = assignment.type;

    storageList.add(storageMap);

    box.write('assignments', storageList);
  }

  void restoreAssignments() {
    if (box.hasData('assignments')) {
      storageList = box.read('assignments');
    }
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
          date: DateFormat('yyyy-MM-dd').parse(map[dateKey]),
          type: map[typeKey]);

      _assignments.add(assignment);
    }
  }

  void clearAssignments() {
    _assignments.clear();
    storageList.clear();
    box.erase();
  }

  void update(Assignment assignment) {
    storeAndAddAssignment(assignment);
    setState(() {});
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
      body: ListView.builder(
          itemCount: _assignments.length,
          itemBuilder: (context, index) {
            final item = AssignmentListItem(_assignments[index]);
            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          }),
      drawer: createDrawer(context, "Homework"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateAssignmentPage(
                        title: 'Add Assignment',
                        assignments: _assignments,
                        courses: _courses,
                        update: update,
                        getState: getState,
                      )));
          setState(() {});
        },
        tooltip: 'Add Assignment',
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
  final DateTime date;

  Assignment(
      {required this.name,
      required this.course,
      required this.date,
      required this.type});
}

class AssignmentListItem {
  Assignment item;
  final DateFormat formatter = DateFormat('MM-dd-yy');

  AssignmentListItem(this.item);

  Widget buildTitle(BuildContext context) => Text(item.name);

  Widget buildSubtitle(BuildContext context) =>
      Text(item.course + " " + item.type + " " + formatter.format(item.date));
}
