import 'package:flutter/material.dart';
import 'package:food_panda_uber_eats_app/widgets/progress_bar.dart';

// ignore: must_be_immutable
class LoadingDialog extends StatelessWidget {
  String message;

  LoadingDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Column(
      children: [
        circularProgress(),
        const SizedBox(
          height: 20,
        ),
        Text('$message please wait')
      ],
    ));
  }
}
