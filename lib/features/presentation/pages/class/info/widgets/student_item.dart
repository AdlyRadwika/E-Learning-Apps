import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/features/domain/entities/class/class_user.dart';
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
        subtitle:
            Text('Joined at ${data?.joinedAt ?? DateTime.now().toString()}'),
      ),
    );
  }
}
