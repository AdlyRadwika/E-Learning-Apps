
import 'package:final_project/features/presentation/pages/home/widgets/calendar_widget.dart';
import 'package:final_project/features/presentation/pages/home/widgets/grade_widget.dart';
import 'package:final_project/features/presentation/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, ProfilePage.route),
            icon: const Icon(Icons.edit),
            label: const Text('Configure Your Profile')),
        const SizedBox(
          height: 20,
        ),
        const GradeWidget(),
        const SizedBox(
          height: 20,
        ),
        const CalendarWidget()
      ],
    );
  }
}