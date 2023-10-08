import 'package:final_project/features/presentation/pages/class/detail/widgets/announcement_item.dart';
import 'package:flutter/material.dart';

class AnnouncementSection extends StatelessWidget {
  const AnnouncementSection({
    super.key,
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
            GestureDetector(child: const Text('See More')),
          ],
        ),
        SizedBox(
          height: 300,
          child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemBuilder: (context, index) {
                return const AnnoucementItem();
              }),
        )
      ],
    );
  }
}
