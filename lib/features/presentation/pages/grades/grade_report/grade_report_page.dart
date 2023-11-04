import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/class_index/class_index_bloc.dart';
import 'package:final_project/features/presentation/pages/grades/widgets/final_grade_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GradeReportPage extends StatefulWidget {
  static const route = '/grade-report';

  const GradeReportPage({super.key});

  @override
  State<GradeReportPage> createState() => _GradeReportPageState();
}

class _GradeReportPageState extends State<GradeReportPage> {
  Future<void> _getData() async {
    if (!mounted) return;
    final bloc = context.read<ClassIndexBloc>();
    bloc.add(GetEnrolledClassesByIdEvent(uid: UserConfigUtil.uid));
  }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Report'),
      ),
      body: BlocBuilder<ClassIndexBloc, ClassIndexState>(
          builder: (context, state) {
        if (state is GetEnrolledClassesByIdLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetEnrolledClassesByIdResult && state.isSuccess) {
          return StreamBuilder(
            stream: state.classesStream,
            builder: (context, snapshot) {
              final docs = snapshot.data?.docs;
              if (docs?.isEmpty == true) {
                return const Center(
                  child: Text("You currently have no classes"),
                );
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = docs?.map((item) => item.data().toEntity()).toList();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomScrollView(
                  slivers: [
                    FinalGradeList(
                      classes: null,
                      enrolledClasses: data,
                    )
                  ],
                ),
              );
            },
          );
        }
        if (state is GetEnrolledClassesByIdResult && !state.isSuccess) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.message),
              ElevatedButton(
                  onPressed: () => _getData(), child: const Text('Try Again'))
            ],
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Something went wrong."),
            ElevatedButton(
                onPressed: () => _getData(), child: const Text('Try Again'))
          ],
        );
      }),
    );
  }
}
