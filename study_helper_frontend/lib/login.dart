import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

Future<String> postRequest(String email, String? hash) async {
  var data = {};
  if (hash == null) {
    data = <String, String>{'email': email};
  } else {
    data = <String, String>{'email': email, 'hash': hash};
  }
  http.Response response = await http.post(
      Uri.parse(
          'https://upqlg48wn7.execute-api.us-east-1.amazonaws.com/default/StudyHelperBacken'),
      headers: {'Access-Control-Allow-Origin': '*'},
      body: jsonEncode(data));
  if (response.statusCode == 400) {
    throw response.body;
  } else if (response.statusCode == 200) {
    return response.body;
  } else {
    throw "what";
  }
}

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
