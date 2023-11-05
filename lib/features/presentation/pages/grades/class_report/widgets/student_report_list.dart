import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/features/domain/entities/class/class_user.dart';
import 'package:final_project/features/presentation/pages/grades/student_report/student_report_page.dart';
import 'package:flutter/material.dart';

import 'package:final_project/features/presentation/bloc/class_cloud/get_class_students/get_class_students_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentReportList extends StatelessWidget {
  final String classCode;
  
  const StudentReportList({
    super.key, required this.classCode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetClassStudentsBloc, GetClassStudentsState>(
        builder: (context, state) {
      if (state is GetClassStudentsLoading) {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is GetClassStudentsResult && state.isSuccess) {
        final students = state.students;
        if (students?.isEmpty == true) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('There are no students yet.'),
            ),
          );
        }
        return SliverList.separated(
          itemCount: students?.length,
          itemBuilder: (context, index) {
            final data = students?[index];
            return _StudentReportItem(data, classCode);
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        );
      }
      if (state is GetClassStudentsResult && !state.isSuccess) {
        return SliverList.separated(
          itemCount: 1,
          itemBuilder: (context, index) {
            return const _StudentReportItem(null, null);
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        );
      }
      return const SliverPadding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        sliver: SliverToBoxAdapter(
          child: Center(child: Text('Something went wrong.')),
        ),
      );
    });
  }
}

class _StudentReportItem extends StatelessWidget {
  final ClassUser? data;
  final String? classCode;

  const _StudentReportItem(this.data, this.classCode);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, StudentReportPage.route, arguments: {
          'className': '-',
          'classCode': classCode ?? '-',
          'studentId': data?.uid ?? '-',
          'studentName': data?.name ?? '-'
        }),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              NetworkImage(data?.imageUrl ?? AssetConts.imageUserDefault),
        ),
        title: Text(data?.name ?? "Someone"),
        trailing: const Icon(Icons.edit),
      ),
    );
  }
}
