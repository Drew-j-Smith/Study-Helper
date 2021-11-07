import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';
import 'package:email_validator/email_validator.dart';
import 'web_calls.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
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
                    child: Form(
                        key: _formKey,
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
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email can not be empty.';
                                  }
                                  if (!EmailValidator.validate(value)) {
                                    return 'Email invalid.';
                                  }
                                  return null;
                                }),
                            TextFormField(
                              autocorrect: false,
                              obscureText: true,
                              controller: passController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter your password',
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            debugPrint(emailController.text);
                                            debugPrint(passController.text);
                                            var saltJson = jsonDecode(
                                                await postRequest(
                                                    emailController.text,
                                                    null));
                                            debugPrint(saltJson.toString());
                                            final hash = Crypt.sha256(
                                                passController.text,
                                                salt: saltJson["salt"]
                                                    .toString());
                                            debugPrint(hash.hash);
                                            debugPrint(hash.salt);
                                            var userJson = jsonDecode(
                                                await postRequest(
                                                    emailController.text,
                                                    hash.hash));
                                            debugPrint(userJson.toString());
                                          }
                                        },
                                        child: const Text(
                                          'Login',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15,
                                                horizontal: 30)))))
                          ],
                        ))))));
  }
}
