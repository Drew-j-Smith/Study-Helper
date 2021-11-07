import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_helper_frontend/main.dart';
import 'elements/drawer.dart';
import 'data_storage/course.dart';
import 'create_assignment.dart';
import 'package:get_storage/get_storage.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: StaticApplicationData.data.assignments.length,
          itemBuilder: (context, index) {
            final item = StaticApplicationData.data.assignments[index];
            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          }),
      drawer: createDrawer(context, "Homework"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateAssignmentPage(
                        title: 'Add Assignment',
                        updateParent: update,
                      )));
          setState(() {});
        },
        tooltip: 'Add Assignment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
