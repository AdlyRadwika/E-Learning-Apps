import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/presentation/bloc/attendance_cloud/get_attendance/get_attendance_bloc.dart';
import 'package:final_project/features/presentation/bloc/attendance_cloud/get_attendance_status/get_attendance_status_bloc.dart';
import 'package:final_project/features/presentation/pages/class/attendance/widgets/attendance_fab.dart';
import 'package:final_project/features/presentation/pages/class/attendance/widgets/attendance_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendancePage extends StatefulWidget {
  static const route = '/class-attendance';

  final String classCode;
  final String classTitle;

  const AttendancePage(
      {super.key, required this.classCode, required this.classTitle});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  void _getData() {
    context
        .read<GetAttendancesBloc>()
        .add(GetAttendancesByClassEvent(classCode: widget.classCode));
    context.read<GetAttendanceStatusBloc>().add(
        GetAttendanceStatusByStudentEvent(
            classCode: widget.classCode, studentId: UserConfigUtil.uid));
  }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.classTitle} Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: BlocBuilder<GetAttendancesBloc, GetAttendancesState>(
            builder: (context, state) {
          if (state is GetAttendancesByClassLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetAttendancesByClassResult && !state.isSuccess) {
            return Column(
              children: [
                Text(state.message),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () => _getData(), child: const Text('Try Again'))
              ],
            );
          }
          if (state is GetAttendancesByClassResult && state.isSuccess) {
            final data = state.attendances;
            if (data?.isEmpty == true) {
              return const Center(
                child: Text('There is no attendances yet'),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                return Future.sync(() {
                  _getData();
                });
              },
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return AttendanceItem(
                    data: data?[index],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: data?.length ?? 1,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () {
              return Future.sync(() {
                _getData();
              });
            },
            child: ListView.separated(
              itemBuilder: (context, index) {
                return const AttendanceItem(
                  data: null,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: 5,
            ),
          );
        }),
      ),
      floatingActionButton:
          AttendanceFAB(classCode: widget.classCode),
    );
  }
}
