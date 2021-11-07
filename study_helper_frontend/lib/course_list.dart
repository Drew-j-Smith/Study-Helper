import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:study_helper_frontend/main.dart';
import 'elements/drawer.dart';
import 'create_course.dart';
import 'main.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  @override
  void initState() {
    super.initState();
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: createDrawer(context, "Courses"),
      body: ListView.builder(
          itemCount: StaticApplicationData.data.courses.length,
          itemBuilder: (context, index) {
            final item = StaticApplicationData.data.courses[index];
            return ListTile(title: item.buildTitle(context));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateCoursePage(
                      title: 'Add Course', updateParent: update)));
          setState(() {});
        },
        tooltip: 'Add Course',
        child: const Icon(Icons.add),
      ),
    );
  }
}
