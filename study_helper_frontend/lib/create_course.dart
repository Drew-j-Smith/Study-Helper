import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateCoursePage extends StatefulWidget {
  const CreateCoursePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _CreateCoursePageState createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  // TODO - fix this stuff
  final nameController = TextEditingController();
  final courseController = TextEditingController();
  final dateController = TextEditingController();
  final typeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
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
            Navigator.pop(context);
          },
          tooltip: 'Add Course',
          child: const Icon(Icons.save),
        ));
  }
}
