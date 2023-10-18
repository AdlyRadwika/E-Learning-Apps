import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/announcements/post_announcement_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAnnouncementWidget extends StatelessWidget {
  final String classCode;

  const PostAnnouncementWidget({
    super.key, required this.classCode,
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
            onPressed: () =>
                Navigator.pushNamed(context, PostAnnouncementPage.route, arguments: {
                  'classCode': classCode,
                  'contentText': '',
                  'isUpdate': false,
                  'announcementId': '-'
                }),
            icon: const Icon(Icons.announcement),
            label: const Text('Post Announcement')),
      );
    });
  }
}
