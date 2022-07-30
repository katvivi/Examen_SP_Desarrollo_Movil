import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MiCalculadora());
}

class MiCalculadora extends StatelessWidget {
  const MiCalculadora({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
