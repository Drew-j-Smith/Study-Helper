import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

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
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      debugPrint(emailController.text);
                                      debugPrint(passController.text);
                                      final hash =
                                          Crypt.sha256(passController.text);
                                      debugPrint(hash.hash);
                                      debugPrint(hash.salt);
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 30)))))
                      ],
                    )))));
  }
}
