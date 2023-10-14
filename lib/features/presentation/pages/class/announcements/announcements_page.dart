import 'package:final_project/features/presentation/pages/class/widgets/announcement_item.dart';
import 'package:flutter/material.dart';

class AnnouncementsPage extends StatelessWidget {
  static const route = '/class-announcements';

  const AnnouncementsPage({super.key});

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
            SliverList.separated(
              itemCount: 10,
              itemBuilder: (context, index) => const AnnoucementItem(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
