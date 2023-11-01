
import 'package:final_project/common/util/date_util.dart';
import 'package:flutter/material.dart';

class StudentAssignmentInfo extends StatelessWidget {
  const StudentAssignmentInfo({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Text(
            'Student of Class 1',
            style: theme.textTheme.titleLarge,
          ),
        ),
        const SliverToBoxAdapter(
          child: Divider(),
        ),
        SliverList.separated(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                //TODO: implement me
                onTap: () => print,
                leading: const Icon(Icons.assignment_ind_outlined),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      'Assignment 1',
                      overflow: TextOverflow.ellipsis,
                    )),
                    Expanded(
                        child: Text(
                      'Score',
                      textAlign: TextAlign.end,
                    )),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                          DateUtil.formatDate(DateTime.now().toString())),
                    ),
                    Expanded(
                      child: Text(
                        '80',
                        style: theme.textTheme.titleLarge,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        )
      ],
    );
  }
}
