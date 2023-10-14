import 'package:final_project/features/presentation/pages/class/assignment_detail/widgets/assignment_info.dart';
import 'package:final_project/features/presentation/pages/class/assignment_detail/widgets/submission_content.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class AssignmentDetailPage extends StatelessWidget {
  static const route = '/assignment-detail';

  const AssignmentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment Detail'),
      ),
      body: SlidingUpPanel(
        maxHeight: 400.0,
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 10.0,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        panelBuilder: () => const SubmissionContent(),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: AssignmentInfo(),
        ),
      ),
    );
  }
}
