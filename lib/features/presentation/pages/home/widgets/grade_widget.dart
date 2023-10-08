import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GradeWidget extends StatelessWidget {
  const GradeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child:
          BlocBuilder<UserCloudBloc, UserCloudState>(builder: (context, state) {
        if (state is GetUserByIdResult && state.isSuccess) {
          final isStudent = state.user?.role == 'student';
          return Text(
            isStudent ? 'Grade Report' : 'Mark Grades',
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
          );
        }
        return Text(
          'Unknown Container',
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
        );
      })),
    );
  }
}
