import 'package:flutter/material.dart';

Scaffold createLoginPage(List<Widget> children, String title, Key? formKey) {
  return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
          child: SizedBox(
              width: 500,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: children,
                      ))))));
}
