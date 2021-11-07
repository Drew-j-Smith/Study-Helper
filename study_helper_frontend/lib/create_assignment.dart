import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateAssignmentPage extends StatefulWidget {
  const CreateAssignmentPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _CreateAssignmentPageState createState() => _CreateAssignmentPageState();
}

class _CreateAssignmentPageState extends State<CreateAssignmentPage> {
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
                                  labelText: 'Assignment Name'),
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
                              items: <String>[
                                'thing1',
                                'thing2'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()));
                              return time == null
                                  ? null
                                  : DateTimeField.convert(time);
                            },
                          )
                        ],
                      ),
                    ))))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO - actually save
            Navigator.pop(context);
          },
          tooltip: 'Add Assignment',
          child: const Icon(Icons.save),
        ));
  }
}
