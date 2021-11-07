import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'create_course.dart';
import 'main.dart';
import 'login.dart';
import 'create_account.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  List<Course> _courses = [];

  final box = GetStorage(); // list of maps stored here

  List storageList = [];

  void addAndStoreCourse(Course course) {
    _courses.add(course);

    final storageMap = {}; // temp map
    final index = _courses.length; // unique map keys
    final courseNameKey = 'courseName$index';

    storageMap[courseNameKey] = course.courseName;

    storageList.add(storageMap);

    box.write('courses', storageList);
  }

  void restoreCourses() {
    if (box.hasData('courses')) {
      storageList = box.read('courses');
    }
    String courseNameKey;
    for (int i = 0; i < storageList.length; i++) {
      final map = storageList[i];
      final index = i + 1;

      courseNameKey = 'courseName$index';

      // recreate assignment object

      final course = Course(courseName: map[courseNameKey]);

      _courses.add(course);
    }
  }

  void clearAssignments() {
    _courses.clear();
    storageList.clear();
    box.erase();
  }

  @override
  void initState() {
    super.initState();
    restoreCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Center(
                  child: Text('Study Helper',
                      style: TextStyle(fontSize: 40, color: Colors.white)))),
          ListTile(
            title: const Text('Homework'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      const AssignmentPage(title: 'Homework')));
            },
          ),
          ListTile(
            title: const Text('Courses'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
              title: const Text('Login'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage(title: 'Login')));
              }),
          ListTile(
              title: const Text('Create Account'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CreateAccountPage(title: 'Create Account')));
              }),
        ]),
      ),
      body: ListView.builder(
          itemCount: _courses.length,
          itemBuilder: (context, index) {
            final item = CourseListItem(_courses[index]);
            return ListTile(title: item.buildTitle(context));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const CreateCoursePage(title: 'Add Course')));
          final course = Course(courseName: 'Course Test');
          addAndStoreCourse(course);
          setState(() {});
        },
        tooltip: 'Add Course',
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

class Course {
  final String courseName;

  Course({required this.courseName});
}

class CourseListItem {
  Course courseItem;

  CourseListItem(this.courseItem);

  Widget buildTitle(BuildContext context) => Text(courseItem.courseName);
}
