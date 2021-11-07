import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'elements/email_text_form_field.dart';
import 'elements/password_text_form_field.dart';
import 'elements/login_page_template.dart';
import 'elements/login_button.dart';

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
    return createLoginPage([
      createEmailTextFormField(emailController),
      createPasswordTextFormField(
          passController, 'Enter your password', (password) => null),
      createLoginButton(_formKey, emailController, passController)
    ], widget.title, _formKey);
  }
}
