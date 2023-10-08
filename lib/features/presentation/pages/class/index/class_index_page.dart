import 'package:final_project/features/presentation/pages/class/index/widgets/class_button.dart';
import 'package:final_project/features/presentation/pages/class/index/widgets/class_item.dart';
import 'package:flutter/material.dart';

class ClassIndexPage extends StatelessWidget {
  static const route = '/class';

  const ClassIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
          itemCount: 3,
          itemBuilder: (context, index) {
            return const ClassItem();
          }),
      floatingActionButton: const ActionButton(),
    );
  }
}
