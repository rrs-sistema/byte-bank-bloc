import 'package:flutter/material.dart';

import './components/components.dart';
import '../screens/screens.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: bytebankTheme,
      home: NameContainer(),
    );
  }
}
