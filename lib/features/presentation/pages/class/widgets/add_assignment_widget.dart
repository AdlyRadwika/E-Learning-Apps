import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/assignments/add_assignment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAssignmentWidget extends StatelessWidget {
  final Assignment? data;
  final bool isEdit;
  final String classCode;

  const AddAssignmentWidget({
    super.key,
    required this.data,
    required this.isEdit, required this.classCode,
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
                    context, AddAssignmentPage.route,
                    arguments: {
                      'data': data,
                      'isEdit': isEdit,
                      'classCode': classCode,
                    }),
            icon: const Icon(Icons.add),
            label: const Text('Add Assignment')),
      );
    });
  }
}
