
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/assignments/add_assignment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAssignmentWidget extends StatelessWidget {
  const AddAssignmentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCloudBloc, UserCloudState>(
        builder: (context, state) {
      if (state is GetUserByIdResult && state.isSuccess) {
        final data = state.user;
        if (data?.role == "student") {
          return const SizedBox.shrink();
        }
      }
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(
                context, AddAssignmentPage.route),
            icon: const Icon(Icons.add),
            label: const Text('Add Assignment')),
      );
    });
  }
}
