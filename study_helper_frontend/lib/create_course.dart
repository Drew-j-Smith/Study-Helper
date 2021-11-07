import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:study_helper_frontend/elements/input_page_template.dart';
import 'data_storage/course.dart';
import 'package:study_helper_frontend/main.dart';

class CreateCoursePage extends StatefulWidget {
  const CreateCoursePage(
      {Key? key, required this.title, required this.updateParent})
      : super(key: key);
  final String title;
  final Function updateParent;
  @override
  _CreateCoursePageState createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
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
    return createInputPage(
        [
          TextFormField(
            controller: courseNameController,
            autocorrect: false,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Course Name'),
          ),
        ],
        widget.title,
        _formKey,
        MainAxisAlignment.start,
        FloatingActionButton(
          onPressed: () {
            StaticApplicationData.data.courses
                .add(Course(name: courseNameController.text));
            GetStorage().write('data', StaticApplicationData.data.toJson());
            Navigator.pop(context);
            widget.updateParent();
          },
          tooltip: 'Add Course',
          child: const Icon(Icons.save),
        ),
        700);
  }
}
