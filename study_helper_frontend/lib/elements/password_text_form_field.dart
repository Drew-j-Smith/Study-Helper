import 'package:flutter/material.dart';

TextFormField createPasswordTextFormField(TextEditingController? passController,
    String labelText, String? Function(String?)? validator) {
  return TextFormField(
      autocorrect: false,
      obscureText: true,
      controller: passController,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: labelText,
      ),
      validator: validator);
}
