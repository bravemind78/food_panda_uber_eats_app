import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ErrorDialog extends StatelessWidget {
  String? message;
  // ignore: use_key_in_widget_constructors
  ErrorDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          // ignore: sort_child_properties_last
          child: const Center(child: Text('Ok')),
        )
      ],
    );
  }
}
