import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';
import '../web_calls.dart';

Padding createAcountButton(
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passController) {
  return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
          child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final hash = Crypt.sha256(passController.text);
                  debugPrint(hash.hash);
                  debugPrint(hash.salt);
                  await putRequest(
                      emailController.text, hash.hash, hash.salt, '');
                }
              },
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 20),
              ),
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 30)))));
}
