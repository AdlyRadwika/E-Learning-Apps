import 'package:flutter/material.dart';

class SubmissionContent extends StatelessWidget {
  const SubmissionContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Text(
          'Submission',
          style: theme.textTheme.titleLarge,
        ),
        const Text("It seems that you haven't submitted the assignment yet."),
        const SizedBox(
          height: 40,
        ),
        Container(
          height: 150,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(
            'Add an attachment here',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
          )),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(onPressed: () => print, child: const Text('Submit'))
      ],
    );
  }
}
