import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:study_helper_frontend/main.dart';
import 'elements/input_page_template.dart';
import 'data_storage/course.dart';
import 'data_storage/assignment.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateAssignmentPage extends StatefulWidget {
  const CreateAssignmentPage(
      {Key? key, required this.title, required this.updateParent})
      : super(key: key);
  final String title;
  final Function updateParent;

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
    dateController.dispose();
    typeController.dispose();
    super.dispose();
  }

  String dropdownCourseValue = 'Select course.';
  String type = "";
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
              items: StaticApplicationData.data
                  .getCourseList()
                  .map<DropdownMenuItem<String>>((String value) {
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
                  type = newValue!;
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
            Assignment assignment = Assignment(
                name: nameController.text,
                course:
                    StaticApplicationData.data.findCourse(dropdownCourseValue)!,
                date: DateFormat('MM/dd/yyyy').parse(dateController.text),
                type: type);
            StaticApplicationData.data.assignments.add(assignment);
            GetStorage().write('data', StaticApplicationData.data.toJson());
            Navigator.pop(context);
            widget.updateParent();
          },
          tooltip: 'Add Assignment',
          child: const Icon(Icons.save),
        ),
        700);
  }
}
