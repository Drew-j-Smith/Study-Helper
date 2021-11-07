import 'package:flutter/material.dart';

Scaffold createInputPage(List<Widget> children, String title, Key? formKey,
    MainAxisAlignment mainAxisAlignment, Widget? button, double? width) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(
        child: SizedBox(
            width: width,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: mainAxisAlignment,
                      children: children,
                    ))))),
    floatingActionButton: button,
  );
}
