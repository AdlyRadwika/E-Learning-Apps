import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/common/util/bool_util.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/class_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/index/widgets/class_button.dart';
import 'package:final_project/features/presentation/pages/class/index/widgets/class_item.dart';
import 'package:final_project/features/presentation/pages/class/index/widgets/enrolled_class_item.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassIndexPage extends StatefulWidget {
  static const route = '/class';

  const ClassIndexPage({super.key});

  @override
  State<ClassIndexPage> createState() => _ClassIndexPageState();
}

class _ClassIndexPageState extends State<ClassIndexPage> {
  final _storageService = locator<SecureStorageService>();

  Future<void> _getData() async {
    final uid = await _storageService.getUid();
    if (!mounted) return;
    final provider = context.read<ClassCloudBloc>();
    if (!mounted) return;
    BoolUtil.isTeacher(role: await _storageService.getRole())
        ? provider.add(GetClassesByIdEvent(uid: uid))
        : provider.add(GetEnrolledClassesByIdEvent(uid: uid));
  }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClassCloudBloc, ClassCloudState>(
          builder: (context, state) {
        if (state is GetEnrolledClassesByIdLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetEnrolledClassesByIdResult && state.isSuccess) {
          final data = state.classes;
          if (data?.isEmpty == true) {
            return const Center(
              child: Text("You currently have no classes"),
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return EnrolledClassItem(
                  data: data?[index],
                );
              });
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
        if (state is GetClassesByIdLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetClassesByIdResult && state.isSuccess) {
          final data = state.classes;
          if (data?.isEmpty == true) {
            return const Center(
              child: Text("You currently have no classes"),
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return ClassItem(
                  data: data?[index],
                );
              });
        }
        if (state is GetClassesByIdResult && !state.isSuccess) {
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
      floatingActionButton: const ActionButton(),
    );
  }
}
