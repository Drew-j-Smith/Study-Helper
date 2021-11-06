import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAssignmentPage extends StatefulWidget {
  const CreateAssignmentPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _CreateAssignmentPageState createState() => _CreateAssignmentPageState();
}

class _CreateAssignmentPageState extends State<CreateAssignmentPage> {
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
  String dropdownDateValue = 'Enter a date.';

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
                          ),
                          DropdownButtonFormField<String>(
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownCourseValue = newValue!;
                                });
                              },
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
                        ],
                      ),
                    ))))));
  }
}
