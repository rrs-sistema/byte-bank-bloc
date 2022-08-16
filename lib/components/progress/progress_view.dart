import 'package:flutter/material.dart';

import '../../components/components.dart';

// ignore: must_be_immutable
class ProgressView extends StatelessWidget {
  String message;
  ProgressView({String messages = 'Sending...'}) {
    this.message = messages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Processing'),
      ),
      body: Progress(
        message: message,
      ),
    );
  }
}
