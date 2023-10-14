import 'package:final_project/features/presentation/pages/class/info/widgets/class_info_content.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/student_item.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/teacher_section.dart';
import 'package:flutter/material.dart';

class ClassInfoPage extends StatelessWidget {
  static const route = '/class-info';

  const ClassInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 380,
            title: Text('Class 1 Info'),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(top: 80.0, left: 15.0, right: 15.0),
                child: ClassInfoContent(),
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
