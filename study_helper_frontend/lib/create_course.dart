import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'course_list.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateCoursePage extends StatefulWidget {
  List<Course> courses;
  final Function update;

  CreateCoursePage(
      {Key? key,
      required this.title,
      required this.courses,
      required this.update})
      : super(key: key);
  final String title;
  @override
  _CreateCoursePageState createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  // TODO - fix this stuff
  final courseNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    courseNameController.dispose();
    super.dispose();
  }

  String dropdownCourseValue = 'Select course.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
            child: SizedBox(
                width: 700,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Center(
                        child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: courseNameController,
                            autocorrect: false,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Course Name'),
                          ),
                          // TODO - add more fields for courses
                        ],
                      ),
                    ))))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO - save actual course
            Course course = Course(courseName: courseNameController.text);
            widget.update(course);
            Navigator.pop(context);
          },
          tooltip: 'Add Course',
          child: const Icon(Icons.save),
        ));
  }
}
