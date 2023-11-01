import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/grades/mark_grades/mark_grades_page.dart';
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
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            UserConfigUtil.role == 'student'
                ? Navigator.pushNamed(context, MarkGradePage.route)
                : Navigator.pushNamed(context, MarkGradePage.route);
          },
          child: Center(child: BlocBuilder<UserCloudBloc, UserCloudState>(
              builder: (context, state) {
            if (state is GetUserByIdResult && state.isSuccess) {
              final isStudent = state.user?.role == 'student';
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.background),
                    child: Icon(
                      Icons.grade,
                      color: theme.colorScheme.onBackground,
                      size: 80,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    isStudent ? 'Grade Report' : 'Mark Grades',
                    style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSecondaryContainer),
                  ),
                ],
              );
            }
            return Text(
              'Unknown Container',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.onSecondaryContainer),
            );
          })),
        ),
      ),
    );
  }
}
