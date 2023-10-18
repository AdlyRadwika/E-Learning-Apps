import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/features/domain/entities/class/enrolled_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnrolledClassInfoContent extends StatelessWidget {
  final EnrolledClass? data;

  const EnrolledClassInfoContent({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Code: ${data?.code ?? "ERROR"}',
              style: theme.textTheme.headlineSmall,
            ),
            IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: data?.code ?? 'ERROR'))
                      .then((value) => context.showSnackBar(
                            message: 'Class Code copied to your clipboard.',
                          ));
                },
                icon: const Icon(Icons.copy))
          ],
        ),
        Text(
          'Created at ${data?.createdAt ?? DateTime.now().toString()}',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.grey,
          ),
        ),
        const Divider(),
        Text(data?.description ??
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
      ],
    );
  }
}
