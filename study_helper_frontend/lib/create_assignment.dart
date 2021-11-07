import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'elements/input_page_template.dart';
import 'main.dart';
import 'course_list.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateAssignmentPage extends StatefulWidget {
  List<Assignment> assignments;
  List<Course> courses;

  final Function update;
  final Function getState;

  CreateAssignmentPage(
      {Key? key,
      required this.title,
      required this.assignments,
      required this.courses,
      required this.update,
      required this.getState})
      : super(key: key);
  final String title;

  @override
  _CreateAssignmentPageState createState() => _CreateAssignmentPageState();
}

class _CreateAssignmentPageState extends State<CreateAssignmentPage> {
  // TODO - fix this stuff=

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
  String name = "", type = "", course = "";
  DateTime date = DateTime.now();

  List<String> populateCourses() {
    List<String> courseNames = [];
    for (Course item in widget.getState()["courses"]) {
      courseNames.add(item.courseName);
    }
    return courseNames;
  }

  @override
  Widget build(BuildContext context) {
    List<String> coursesList = populateCourses();
    debugPrint(widget.getState().toString());
    return createInputPage(
        [
          TextFormField(
              controller: nameController,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Assignment Name'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Assignment name can not be empty.';
                }
              }),
          DropdownButtonFormField<String>(
              onChanged: (String? newValue) {
                setState(() {
                  dropdownCourseValue = newValue!;
                });
              },
              // TODO - courses here
              items: coursesList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Course',
              )),
          DropdownButtonFormField<String>(
              onChanged: (String? newValue) {
                setState(() {
                  type = newValue.toString();
                  dropdownCourseValue = newValue!;
                });
              },
              items: <String>[
                'Homework',
                'Project',
                'Reading',
                'Lab',
                'Quiz',
                'Test',
                'Midterm',
                'Final'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Type',
              )),
          DateTimeField(
            controller: dateController,
            format: DateFormat('MM/dd/yyyy'),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Due Date',
            ),
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2099));
            },
            validator: (DateTime? value) {
              date = DateTime.parse(value.toString());
              if (value == null) {
                return 'Must enter date.';
              }
              return null;
            },
          ),
          DateTimeField(
            format: DateFormat('hh:mm a'),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Due Time',
            ),
            onShowPicker: (context, currentValue) async {
              final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()));
              return time == null ? null : DateTimeField.convert(time);
            },
          )
        ],
        widget.title,
        _formKey,
        MainAxisAlignment.start,
        FloatingActionButton(
          onPressed: () {
            // TODO - actually save
            Assignment assignment = Assignment(
                name: nameController.text,
                course: course,
                date: DateFormat('MM/dd/yyyy').parse(dateController.text),
                type: type);
            widget.update(assignment);
            Navigator.pop(context);
          },
          tooltip: 'Add Assignment',
          child: const Icon(Icons.save),
        ),
        700);
  }
}
