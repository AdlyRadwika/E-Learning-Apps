import 'package:final_project/features/presentation/pages/class/attendance/attendance_page.dart';
import 'package:final_project/features/presentation/pages/class/detail/widgets/annoucement_section.dart';
import 'package:final_project/features/presentation/pages/class/detail/widgets/assignment_item.dart';
import 'package:final_project/features/presentation/pages/class/info/class_info_page.dart';
import 'package:flutter/material.dart';

class ClassDetailPage extends StatelessWidget {
  static const route = '/class-detail';

  const ClassDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class 1'),
        actions: [
          IconButton(
              tooltip: 'Class Info',
              onPressed: () =>
                  Navigator.pushNamed(context, ClassInfoPage.route),
              icon: const Icon(Icons.info_outline))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: AnnouncementSection()),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Assignments',
                    style: theme.textTheme.titleLarge,
                  ),
                  GestureDetector(child: const Text('See More')),
                ],
              ),
            ),
            SliverList.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const AssignmentItem();
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, AttendancePage.route),
          label: const Text('Attendance')),
    );
  }
}
