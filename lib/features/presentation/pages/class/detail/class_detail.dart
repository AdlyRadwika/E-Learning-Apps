import 'package:final_project/features/domain/entities/class/class.dart';
import 'package:final_project/features/presentation/pages/class/assignments/assignments_page.dart';
import 'package:final_project/features/presentation/pages/class/attendance/attendance_page.dart';
import 'package:final_project/features/presentation/pages/class/detail/widgets/annoucement_section.dart';
import 'package:final_project/features/presentation/pages/class/widgets/add_assignment_widget.dart';
import 'package:final_project/features/presentation/pages/class/widgets/assignment_item.dart';
import 'package:final_project/features/presentation/pages/class/info/class_info_page.dart';
import 'package:flutter/material.dart';

class ClassDetailPage extends StatelessWidget {
  static const route = '/class-detail';

  const ClassDetailPage({super.key, required this.data});

  final Class? data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(data?.title ?? 'Unknown Class'),
          actions: [
            IconButton(
                tooltip: 'Class Info',
                onPressed: () => Navigator.pushNamed(
                    context, ClassInfoPage.route,
                    arguments: {'data': data}),
                icon: const Icon(Icons.info_outline))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: AnnouncementSection(),
              )),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Assignments',
                      style: theme.textTheme.titleLarge,
                    ),
                    GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AssignmentsPage.route),
                        child: const Text('See More')),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: AddAssignmentWidget(),
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
      ),
    );
  }
}
