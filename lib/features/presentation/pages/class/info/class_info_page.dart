import 'package:final_project/features/domain/entities/class/class.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/class_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/class_info_content.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/student_section.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/teacher_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassInfoPage extends StatefulWidget {
  static const route = '/class-info';

  const ClassInfoPage({super.key, required this.data});

  final Class? data;

  @override
  State<ClassInfoPage> createState() => _ClassInfoPageState();
}

class _ClassInfoPageState extends State<ClassInfoPage> {
  @override
  void initState() {
    super.initState();

    final classCode = widget.data?.code;
    context.read<ClassCloudBloc>()
      ..add(GetClassTeacherEvent(classCode: classCode ?? "-"))
      ..add(GetClassStudentsEvent(classCode: classCode ?? "-"));
  }

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
            title: Text('${widget.data?.title ?? "Unknown Class"} Info'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClassInfoContent(
                data: widget.data,
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
          const StudentSectionWidget(),
        ],
      ),
    );
  }
}
