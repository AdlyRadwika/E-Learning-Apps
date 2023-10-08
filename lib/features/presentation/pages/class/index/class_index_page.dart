import 'package:flutter/material.dart';

class ClassIndexPage extends StatelessWidget {
  static const route = '/class';

  const ClassIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.lightBlue[200],
          ),
          child: const Center(
            child: Text('Class 1'),
          ),
        ),
      ),
    );
  }
}
