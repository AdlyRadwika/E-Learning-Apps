import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionResultAppBar extends StatelessWidget {
  const ActionResultAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCloudBloc, UserCloudState>(
        builder: (context, state) {
      if (state is GetUserByIdResult && state.isSuccess) {
        final isTeacher = state.user?.role == "teacher";
        if (isTeacher) {
          return const Text('Create a Class');
        }
      }
      return const Text('Join a Class');
    });
  }
}
