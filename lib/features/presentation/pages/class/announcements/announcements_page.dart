import 'package:final_project/features/presentation/pages/class/widgets/announcement_list.dart';
import 'package:final_project/features/presentation/pages/class/widgets/post_announcement_widget.dart';
import 'package:flutter/material.dart';

class AnnouncementsPage extends StatelessWidget {
  static const route = '/class-announcements';

  final String classCode;
  const AnnouncementsPage({super.key, required this.classCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PostAnnouncementWidget(
                classCode: classCode,
              ),
            ),
            const AnnouncementListWidget(
              shouldLimit: false,
            ),
          ],
        ),
      ),
    );
  }
}
