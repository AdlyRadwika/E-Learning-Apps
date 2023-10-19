import 'package:final_project/features/domain/entities/class/class.dart';
import 'package:final_project/features/presentation/bloc/announcement_cloud/get_announcement/get_announcements_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_assignment/get_assignment_bloc.dart';
import 'package:final_project/features/presentation/pages/class/assignments/assignments_page.dart';
import 'package:final_project/features/presentation/pages/class/attendance/attendance_page.dart';
import 'package:final_project/features/presentation/pages/class/detail/widgets/annoucement_section.dart';
import 'package:final_project/features/presentation/pages/class/widgets/add_assignment_widget.dart';
import 'package:final_project/features/presentation/pages/class/widgets/announcement_list.dart';
import 'package:final_project/features/presentation/pages/class/info/class_info_page.dart';
import 'package:final_project/features/presentation/pages/class/widgets/assignment_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassDetailPage extends StatefulWidget {
  static const route = '/class-detail';

  const ClassDetailPage({super.key, required this.data});

  final Class? data;

  @override
  State<ClassDetailPage> createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
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
                    context, ClassInfoPage.route,
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
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                    child: AnnouncementSection(
                  classCode: widget.data?.code ?? "-",
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
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.pushNamed(context, AttendancePage.route),
            label: const Text('Attendance')),
      ),
    );
  }
}
