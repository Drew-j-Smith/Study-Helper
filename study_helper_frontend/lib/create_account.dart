import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'elements/email_text_form_field.dart';
import 'elements/password_text_form_field.dart';
import 'elements/input_page_template.dart';
import 'elements/create_account_button.dart';

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
    return createInputPage([
      createEmailTextFormField(emailController),
      createPasswordTextFormField(passController, "Enter your password",
          (String? value) {
        if (value == null || value.isEmpty) {
          return 'Password can not be empty.';
        }
        return null;
      }),
      createPasswordTextFormField(
          passVerifyController, 'Enter your password again', (String? value) {
        if (value != passController.text) {
          return 'Passwords do not match.';
        }
        return null;
      }),
      createAcountButton(_formKey, emailController, passController)
    ], widget.title, _formKey, MainAxisAlignment.center, null, 500);
  }
}
