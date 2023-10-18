import 'package:final_project/features/domain/entities/class/enrolled_class.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/enrolled_class_info_content.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/student_item.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/teacher_section.dart';
import 'package:flutter/material.dart';

class EnrolledClassInfoPage extends StatelessWidget {
  static const route = '/enrolled-class-info';

  const EnrolledClassInfoPage({super.key, required this.data});

  final EnrolledClass? data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            snap: false,
            title: Text('${data?.title ?? "Unknown Class"} Info'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: EnrolledClassInfoContent(
                data: data,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TeacherSection(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Text(
                'Students',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            sliver: SliverList.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const StudentItem();
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
