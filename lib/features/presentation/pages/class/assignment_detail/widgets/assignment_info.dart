import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:flutter/material.dart';

class AssignmentInfo extends StatelessWidget {
  final bool isTeacher;
  final Assignment? data;

  const AssignmentInfo({
    super.key,
    required this.isTeacher,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?.title ?? "Unknown Title",
                style: theme.textTheme.titleLarge,
              ),
              Text(
                'Due ${DateUtil.formatDate(data?.deadline ?? DateTime.now().toString())}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          isTeacher
              ? const SizedBox.shrink()
              : Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Unsubmitted',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
          const Divider(),
          Text(data?.description ??
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
        ],
      ),
    );
  }
}
