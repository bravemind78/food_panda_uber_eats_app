// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

circularProgress() => Container(
      child: const Padding(
        padding: EdgeInsets.only(top: 12),
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.amber)),
      ),
    );
