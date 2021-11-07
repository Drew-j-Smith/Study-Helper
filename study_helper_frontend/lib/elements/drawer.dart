import 'package:flutter/material.dart';

import '../course_list.dart';
import '../create_account.dart';
import '../login.dart';
import '../main.dart';

Drawer createDrawer(BuildContext context, String currentPage) {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: [
      const DrawerHeader(
          decoration: BoxDecoration(color: Colors.purple),
          child: Center(
              child: Text('Study Helper',
                  style: TextStyle(fontSize: 40, color: Colors.white)))),
      ListTile(
        title: const Text('Homework'),
        onTap: () {
          if (currentPage == 'Homework') {
            Navigator.pop(context);
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AssignmentPage(title: 'Homework')));
          }
        },
      ),
      ListTile(
        title: const Text('Courses'),
        onTap: () {
          if (currentPage == 'Courses') {
            Navigator.pop(context);
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const CourseListPage(title: 'Courses')));
          }
        },
      ),
      ListTile(
          title: const Text('Login'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage(title: 'Login')));
          }),
      ListTile(
          title: const Text('Create Account'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const CreateAccountPage(title: 'Create Account')));
          }),
      ListTile(title: const Text('Sync'), onTap: () {}),
    ]),
  );
}
