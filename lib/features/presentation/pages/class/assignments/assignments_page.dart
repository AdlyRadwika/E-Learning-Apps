import 'package:final_project/features/presentation/pages/class/widgets/add_assignment_widget.dart';
import 'package:final_project/features/presentation/pages/class/widgets/assignment_item.dart';
import 'package:flutter/material.dart';

class AssignmentsPage extends StatelessWidget {
  static const route = '/class-assignments';

  const AssignmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: AddAssignmentWidget(),
            ),
            SliverList.separated(
              itemCount: 10,
              itemBuilder: (context, index) => const AssignmentItem(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
