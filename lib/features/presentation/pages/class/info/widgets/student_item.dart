import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/domain/entities/class/class_user.dart';
import 'package:final_project/features/presentation/pages/profile/other_profile_page.dart';
import 'package:flutter/material.dart';

class StudentItem extends StatelessWidget {
  final ClassUser? data;

  const StudentItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, OtherProfilePage.route,
            arguments: {"uid": data?.uid}),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              NetworkImage(data?.imageUrl ?? AssetConts.imageUserDefault),
          radius: 15,
        ),
        title: Text(
          data?.name ?? "Unknown",
          style: theme.textTheme.labelLarge,
        ),
        subtitle: Text(
            'Joined at ${DateUtil.formatDate(data?.joinedAt ?? DateTime.now().toString())}'),
      ),
    );
  }
}
