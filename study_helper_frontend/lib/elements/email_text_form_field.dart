import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

TextFormField createEmailTextFormField(TextEditingController? emailController) {
  return TextFormField(
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
      });
}
