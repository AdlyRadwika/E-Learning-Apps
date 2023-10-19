import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/services/uuid_service.dart';
import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/assignment_cloud_bloc.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAssignmentPage extends StatefulWidget {
  static const route = '/add-assignment';

  final bool isEdit;
  final String classCode;
  final Assignment? data;

  const AddAssignmentPage(
      {super.key, required this.isEdit, required this.data, required this.classCode});

  @override
  State<AddAssignmentPage> createState() => _AddAssignmentPageState();
}

class _AddAssignmentPageState extends State<AddAssignmentPage> {
  final _uuidService = locator<UuidService>();

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleC;
  late TextEditingController _descriptionC;
  late TextEditingController _deadlineC;

  @override
  void initState() {
    super.initState();

    final data = widget.data;
    _titleC = TextEditingController(text: data?.title.trim());
    _descriptionC = TextEditingController(text: data?.description.trim());
    _deadlineC = TextEditingController(text: data?.deadline.trim());
  }

  @override
  void dispose() {
    super.dispose();

    _titleC.dispose();
    _descriptionC.dispose();
    _deadlineC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Assignment'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _titleC,
                  label: 'Assignment Title',
                  icon: Icons.title,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: _descriptionC,
                  label: 'Assignment Description',
                  icon: Icons.description,
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: _deadlineC,
                  label: 'Assignment Deadline',
                  icon: Icons.date_range,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            BlocListener<AssignmentCloudBloc, AssignmentCloudState>(
          listener: (context, state) {
            if (state is InsertAssignmentResult && state.isSuccess) {
              Navigator.pop(context);
              context.showSnackBar(
                  message: 'You have created a new assignment!',
                  backgroundColor: Colors.green);
            } else if (state is InsertAssignmentResult && !state.isSuccess) {
              context.showErrorSnackBar(message: state.message);
            }

            if (state is UpdateAssignmentResult && state.isSuccess) {
              Navigator.pop(context);
              context.showSnackBar(
                  message: 'You have updated the assignment!',
                  backgroundColor: Colors.green);
            } else if (state is UpdateAssignmentResult && !state.isSuccess) {
              context.showErrorSnackBar(message: state.message);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
                onPressed: () => _submit(), child: const Text('Submit')),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final bloc = context.read<AssignmentCloudBloc>();
    final title = _titleC.text.trim();
    final description = _descriptionC.text.trim();
    final deadline = _deadlineC.text.trim();
    final data = widget.data;
    final formData = Assignment(
        id: data?.id ?? _uuidService.generateUuidV4(),
        title: title,
        description: description,
        teacherId: data?.teacherId ?? UserConfigUtil.uid,
        deadline: deadline,
        updatedAt: widget.isEdit ? DateTime.now().toString() : '',
        createdAt: data?.createdAt ?? DateTime.now().toString(),
        classCode: data?.classCode ?? widget.classCode);

    if (_formKey.currentState!.validate()) {
      if (widget.isEdit) {
        bloc.add(UpdateAssignmentEvent(data: formData));
      } else {
        bloc.add(InsertAssignmentEvent(data: formData));
      }
    }
  }
}
