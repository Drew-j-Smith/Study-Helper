import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';
import '../web_calls.dart';

Padding createLoginButton(
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passController) {
  return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
          child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  debugPrint(emailController.text);
                  debugPrint(passController.text);
                  var saltJson =
                      jsonDecode(await postRequest(emailController.text, null));
                  debugPrint(saltJson.toString());
                  final hash = Crypt.sha256(passController.text,
                      salt: saltJson["salt"].toString());
                  debugPrint(hash.hash);
                  debugPrint(hash.salt);
                  var userJson = jsonDecode(
                      await postRequest(emailController.text, hash.hash));
                  debugPrint(userJson.toString());
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 30)))));
}
