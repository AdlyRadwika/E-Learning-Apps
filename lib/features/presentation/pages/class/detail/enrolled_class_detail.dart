import 'package:final_project/features/domain/entities/class/enrolled_class.dart';
import 'package:final_project/features/presentation/bloc/announcement_cloud/get_announcement/get_announcements_bloc.dart';
import 'package:final_project/features/presentation/pages/class/assignments/assignments_page.dart';
import 'package:final_project/features/presentation/pages/class/attendance/attendance_page.dart';
import 'package:final_project/features/presentation/pages/class/detail/widgets/annoucement_section.dart';
import 'package:final_project/features/presentation/pages/class/info/enrolled_class_info_page.dart';
import 'package:final_project/features/presentation/pages/class/widgets/add_assignment_widget.dart';
import 'package:final_project/features/presentation/pages/class/widgets/announcement_list.dart';
import 'package:final_project/features/presentation/pages/class/widgets/assignment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnrolledClassDetailPage extends StatefulWidget {
  static const route = '/enrolled-class-detail';

  const EnrolledClassDetailPage({super.key, required this.data});

  final EnrolledClass? data;

  @override
  State<EnrolledClassDetailPage> createState() =>
      _EnrolledClassDetailPageState();
}

class _EnrolledClassDetailPageState extends State<EnrolledClassDetailPage> {
  void _getData() {
    context
        .read<GetAnnouncementsBloc>()
        .add(GetAnnouncementsByClassEvent(classCode: widget.data?.code ?? "-"));
  }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.data?.title ?? 'Unknown Class'),
          actions: [
            IconButton(
                tooltip: 'Class Info',
                onPressed: () => Navigator.pushNamed(
                    context, EnrolledClassInfoPage.route,
                    arguments: {'data': widget.data}),
                icon: const Icon(Icons.info_outline))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: RefreshIndicator(
            onRefresh: () {
              return Future.sync(() {
                _getData();
              });
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AnnouncementSection(
                    classCode: widget.data?.code ?? "-",
                  ),
                )),
                const AnnouncementListWidget(
                  shouldLimit: true,
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Assignments',
                        style: theme.textTheme.titleLarge,
                      ),
                      GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, AssignmentsPage.route),
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
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.pushNamed(context, AttendancePage.route),
            label: const Text('Attendance')),
      ),
    );
  }
}
