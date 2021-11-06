import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

Future putRequest(String email, String hash, String salt, String data) async {
  http.Response response = await http.put(
      Uri.parse(
          'https://upqlg48wn7.execute-api.us-east-1.amazonaws.com/default/StudyHelperBacken'),
      headers: {'Access-Control-Allow-Origin': '*'},
      body: jsonEncode(<String, String>{
        'email': email,
        'hash': hash,
        'salt': salt,
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password can not be empty.';
                                  }
                                  return null;
                                }),
                            TextFormField(
                                autocorrect: false,
                                obscureText: true,
                                controller: passVerifyController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Enter your password again',
                                ),
                                validator: (String? value) {
                                  if (value != passController.text) {
                                    return 'Passwords do not match.';
                                  }
                                  return null;
                                }),
                            Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final hash = Crypt.sha256(
                                                passController.text);
                                            debugPrint(hash.hash);
                                            debugPrint(hash.salt);
                                            putRequest(emailController.text,
                                                hash.hash, hash.salt, '');
                                          }
                                        },
                                        child: const Text(
                                          'Create Account',
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
