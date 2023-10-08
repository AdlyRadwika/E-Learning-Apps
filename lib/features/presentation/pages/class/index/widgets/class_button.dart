import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/action_result/action_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCloudBloc, UserCloudState>(
        builder: (context, state) {
      if (state is GetUserByIdResult && state.isSuccess) {
        final isTeacher = state.user?.role == "teacher";
        if (isTeacher) {
          return FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, ActionResultPage.route),
            tooltip: 'Add Class',
            child: const Icon(Icons.add),
          );
        }
      }
      return FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, ActionResultPage.route),
        tooltip: 'Join Class',
        child: const Icon(Icons.add),
      );
    });
  }
}
