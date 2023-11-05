import 'package:final_project/features/domain/entities/class/enrolled_class.dart';
import 'package:final_project/features/presentation/bloc/announcement_cloud/get_announcement/get_announcements_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_assignment/get_assignment_bloc.dart';
import 'package:final_project/features/presentation/pages/class/assignments/assignments_page.dart';
import 'package:final_project/features/presentation/pages/class/attendance/attendance_page.dart';
import 'package:final_project/features/presentation/pages/class/detail/widgets/annoucement_section.dart';
import 'package:final_project/features/presentation/pages/class/detail/widgets/expanding_fab.dart';
import 'package:final_project/features/presentation/pages/class/info/enrolled_class_info_page.dart';
import 'package:final_project/features/presentation/pages/class/widgets/add_assignment_widget.dart';
import 'package:final_project/features/presentation/pages/class/widgets/announcement_list.dart';
import 'package:final_project/features/presentation/pages/class/widgets/assignment_list.dart';
import 'package:final_project/features/presentation/pages/grades/student_report/student_report_page.dart';
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
    context
        .read<GetAssignmentsBloc>()
        .add(GetAssignmentsByClassEvent(classCode: widget.data?.code ?? "-"));
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
                                  context, AssignmentsPage.route, arguments: {
                                'classCode': widget.data?.code ?? "-"
                              }),
                          child: const Text('See More')),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: AddAssignmentWidget(
                    classCode: widget.data?.code ?? "-",
                    data: null,
                    isEdit: false,
                  ),
                ),
                AssignmentListWidget(
                  shouldLimit: true,
                  classCode: widget.data?.code ?? "-",
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: ExpandableFab(distance: 80, children: [
          ActionButton(
              onPressed: () => Navigator.pushNamed(
                      context, AttendancePage.route, arguments: {
                    "classCode": widget.data?.code ?? '-',
                    "classTitle": widget.data?.title ?? '-'
                  }),
              tooltip: 'Attendance',
              icon: const Icon(Icons.person_search_sharp)),
          ActionButton(
              tooltip: 'Class Report',
              onPressed: () => Navigator.pushNamed(
                      context, StudentReportPage.route,
                      arguments: {
                        'classCode': widget.data?.code ?? '-',
                        'studentName': '-',
                        'studentId': widget.data?.studentId,
                        'className': widget.data?.title ?? '-',
                      }),
              icon: const Icon(Icons.grade)),
        ]),
      ),
    );
  }
}
