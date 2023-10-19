import 'package:final_project/features/presentation/bloc/class_cloud/get_class_students/get_class_students_bloc.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/student_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentSectionWidget extends StatelessWidget {
  const StudentSectionWidget({
    super.key,
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
        return SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          sliver: SliverList.separated(
            itemCount: students?.length,
            itemBuilder: (context, index) {
              final data = students?[index];
              return StudentItem(
                data: data,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          ),
        );
      }
      if (state is GetClassStudentsResult && !state.isSuccess) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          sliver: SliverList.separated(
            itemCount: 1,
            itemBuilder: (context, index) {
              return const StudentItem(
                data: null,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
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
