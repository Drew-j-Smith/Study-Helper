import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'elements/drawer.dart';
import 'create_course.dart';

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

  void storeAndAddCourse(Course course) {
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

  void update(Course course) {
    storeAndAddCourse(course);
    setState(() {});
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
      drawer: createDrawer(context, "Courses"),
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
                  builder: (context) => CreateCoursePage(
                        title: 'Add Course',
                        courses: _courses,
                        update: update,
                      )));
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

  @override
  String toString() {
    return courseName;
  }
}

class CourseListItem {
  Course courseItem;

  CourseListItem(this.courseItem);

  Widget buildTitle(BuildContext context) => Text(courseItem.courseName);
}