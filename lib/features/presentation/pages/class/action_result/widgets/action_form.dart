import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionResultForm extends StatelessWidget {
  const ActionResultForm({
    super.key,
    required this.formKey,
    required this.titleC,
    required this.descriptionC,
    required this.classCodeC,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleC;
  final TextEditingController descriptionC;
  final TextEditingController classCodeC;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child:
          BlocBuilder<UserCloudBloc, UserCloudState>(builder: (context, state) {
        if (state is GetUserByIdResult && state.isSuccess) {
          final isTeacher = state.user?.role == "teacher";
          if (isTeacher) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                    controller: titleC,
                    label: 'Class Title',
                    icon: Icons.title),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    controller: descriptionC,
                    label: 'Class Description',
                    icon: Icons.description),
              ],
            );
          }
        }
        return Center(
          child: CustomTextFormField(
              controller: classCodeC, label: 'Class Code', icon: Icons.code),
        );
      }),
    );
  }
}
