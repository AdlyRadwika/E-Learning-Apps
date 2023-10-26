import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/get_class_teacher/get_class_teacher_bloc.dart';
import 'package:final_project/features/presentation/pages/profile/other_profile_page.dart';
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
        BlocBuilder<GetClassTeacherBloc, GetClassTeacherState>(
            builder: (context, state) {
          if (state is GetClassTeacherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetClassTeacherResult && state.isSuccess) {
            final data = state.teacher;
            return Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                    context, OtherProfilePage.route,
                    arguments: {"uid": data?.uid}),
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
                    'Joined at ${DateUtil.formatDate(data?.joinedAt ?? DateTime.now().toString())}'),
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
                subtitle: Text(
                    'Joined at ${DateUtil.formatDate(DateTime.now().toString())}'),
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
