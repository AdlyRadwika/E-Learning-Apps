import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/class_cloud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherSection extends StatelessWidget {
  const TeacherSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Teacher',
          style: theme.textTheme.titleLarge,
        ),
        BlocBuilder<ClassCloudBloc, ClassCloudState>(builder: (context, state) {
          if (state is GetClassTeacherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetClassTeacherResult && state.isSuccess) {
            final data = state.teacher;
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                      data?.imageUrl ?? AssetConts.imageUserDefault),
                  radius: 15,
                ),
                title: Text(
                  data?.name ?? "Unknown Teacher",
                  style: theme.textTheme.labelLarge,
                ),
                subtitle: Text(
                    'Joined at ${data?.joinedAt ?? DateTime.now().toIso8601String()}'),
              ),
            );
          }
          if (state is GetClassTeacherResult && !state.isSuccess) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Unknown Teacher',
                  style: theme.textTheme.labelLarge,
                ),
                subtitle: Text('Joined at ${DateTime.now().toString()}'),
              ),
            );
          }
          return const Center(
            child: Text('The teacher is not exist'),
          );
        })
      ],
    );
  }
}
