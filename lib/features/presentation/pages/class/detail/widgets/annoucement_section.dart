import 'package:final_project/features/presentation/pages/class/announcements/announcements_page.dart';
import 'package:final_project/features/presentation/pages/class/widgets/post_announcement_widget.dart';
import 'package:flutter/material.dart';

class AnnouncementSection extends StatelessWidget {
  final String classCode;

  const AnnouncementSection({
    super.key, required this.classCode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Announcement',
              style: theme.textTheme.titleLarge,
            ),
            GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AnnouncementsPage.route, arguments: {
                      'classCode': classCode,
                    }),
                child: const Text('See More')),
          ],
        ),
        PostAnnouncementWidget(
          classCode: classCode,
        ),
      ],
    );
  }
}
