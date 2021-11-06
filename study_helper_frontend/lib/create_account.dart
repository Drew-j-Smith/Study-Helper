import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passVerifyController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    passVerifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
            child: SizedBox(
                width: 500,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          autocorrect: false,
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your email',
                          ),
                        ),
                        TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          controller: passController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your password',
                          ),
                        ),
                        TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          controller: passVerifyController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your password again',
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (passController.text ==
                                              passVerifyController.text &&
                                          EmailValidator.validate(
                                              emailController.text)) {
                                        final hash =
                                            Crypt.sha256(passController.text);
                                        debugPrint(hash.hash);
                                        debugPrint(hash.salt);

                                        http.Response response = await http.put(
                                            Uri.https(
                                                'upqlg48wn7.execute-api.us-east-1.amazonaws.com',
                                                '/default/StudyHelperBacken'),
                                            body: jsonEncode(<String, String>{
                                              'email': emailController.text,
                                              'hash': hash.hash,
                                              'salt': hash.salt,
                                              'data': 'pee',
                                            }));
                                        if (response.statusCode == 400) {
                                          // error
                                        } else if (response.statusCode == 201) {
                                          // we good
                                        } else {
                                          // what
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Create Account',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 30)))))
                      ],
                    )))));
  }
}
