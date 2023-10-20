import 'package:final_project/features/presentation/bloc/assignment_cloud/get_assignment/get_assignment_bloc.dart';
import 'package:final_project/features/presentation/pages/class/widgets/assignment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignmentListWidget extends StatelessWidget {
  final String classCode;
  final bool shouldLimit;

  const AssignmentListWidget({
    super.key,
    required this.classCode,
    required this.shouldLimit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAssignmentsBloc, GetAssignmentsState>(
        builder: (context, state) {
      if (state is GetAssignmentsByClassLoading) {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is GetAssignmentsByClassResult && !state.isSuccess) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              const Text('Something went wrong.'),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<GetAssignmentsBloc>()
                        .add(GetAssignmentsByClassEvent(classCode: classCode));
                  },
                  child: const Text('Try Again'))
            ],
          ),
        );
      }
      if (state is GetAssignmentsByClassResult && state.isSuccess) {
        return StreamBuilder(
            stream: state.assignmentStream,
            builder: (context, snapshot) {
              final docs = snapshot.data?.docs;
              if (docs?.isEmpty == true) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("There is no assignments yet."),
                  ),
                );
              }

              if (snapshot.hasError) {
                return const SliverToBoxAdapter(
                    child: Center(child: Text('Something went wrong')));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              }
              return SliverList.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount:
                      shouldLimit ? docs?.length.clamp(0, 3) : docs?.length,
                  itemBuilder: (context, index) {
                    final data =
                        docs?.map((item) => item.data().toEntity()).toList()
                          ?..sort(
                            (a, b) => DateTime.parse(b.createdAt)
                                .compareTo(DateTime.parse(a.createdAt)),
                          );
                    return AssignmentItem(
                      data: data?[index],
                    );
                  });
            });
      }
      return SliverToBoxAdapter(
        child: Column(
          children: [
            const Text('Something went wrong.'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<GetAssignmentsBloc>()
                      .add(GetAssignmentsByClassEvent(classCode: classCode));
                },
                child: const Text('Try Again'))
          ],
        ),
      );
    });
  }
}
