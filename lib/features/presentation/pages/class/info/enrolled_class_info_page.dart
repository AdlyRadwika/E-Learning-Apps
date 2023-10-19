import 'package:final_project/features/domain/entities/class/enrolled_class.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/get_class_students/get_class_students_bloc.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/get_class_teacher/get_class_teacher_bloc.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/enrolled_class_info_content.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/student_section.dart';
import 'package:final_project/features/presentation/pages/class/info/widgets/teacher_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnrolledClassInfoPage extends StatefulWidget {
  static const route = '/enrolled-class-info';

  const EnrolledClassInfoPage({super.key, required this.data});

  final EnrolledClass? data;

  @override
  State<EnrolledClassInfoPage> createState() => _EnrolledClassInfoPageState();
}

class _EnrolledClassInfoPageState extends State<EnrolledClassInfoPage> {
  @override
  void initState() {
    super.initState();

    final classCode = widget.data?.code;
    context.read<GetClassTeacherBloc>().add(FetchTeacherEvent(classCode: classCode ?? "-"));
    context.read<GetClassStudentsBloc>().add(FetchStudentsEvent(classCode: classCode ?? "-"));
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
              child: EnrolledClassInfoContent(
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
