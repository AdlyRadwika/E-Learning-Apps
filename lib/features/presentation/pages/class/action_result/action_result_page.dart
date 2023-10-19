import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/common/services/uuid_service.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/class_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/action_result/widgets/action_form.dart';
import 'package:final_project/features/presentation/pages/class/action_result/widgets/action_result_appbar.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionResultPage extends StatefulWidget {
  static const route = '/class-action';

  const ActionResultPage({super.key});

  @override
  State<ActionResultPage> createState() => _ActionResultPageState();
}

class _ActionResultPageState extends State<ActionResultPage> {
  final _storageService = locator<SecureStorageService>();
  final _uuidService = locator<UuidService>();

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleC;
  late TextEditingController _descriptionC;
  late TextEditingController _classCodeC;

  @override
  void initState() {
    super.initState();

    _titleC = TextEditingController();
    _descriptionC = TextEditingController();
    _classCodeC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _titleC.dispose();
    _descriptionC.dispose();
    _classCodeC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const ActionResultAppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ActionResultForm(
            formKey: _formKey,
            titleC: _titleC,
            descriptionC: _descriptionC,
            classCodeC: _classCodeC,
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocListener<ClassCloudBloc, ClassCloudState>(
            listener: (context, state) {
              if (state is CreateClassResult && state.isSuccess) {
                Navigator.pop(context);
                context.showSnackBar(
                    message: 'Created class successfully!',
                    backgroundColor: Colors.green);
              } else if (state is CreateClassResult && !state.isSuccess) {
                context.showErrorSnackBar(
                  message: state.message,
                );
              }
              if (state is JoinClassResult && state.isSuccess) {
                Navigator.pop(context);
                context.showSnackBar(
                    message: 'Joined the class successfully!',
                    backgroundColor: Colors.green);
              } else if (state is JoinClassResult && !state.isSuccess) {
                context.showErrorSnackBar(
                  message: state.message,
                );
              }
            },
            child: ElevatedButton(
                onPressed: () => _submit(), child: const Text("Submit")),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final title = _titleC.text.trim();
    final description = _descriptionC.text.trim();
    final uid = await _storageService.getUid();
    final code = _uuidService.generateClassCode();
    final codeInput = _classCodeC.text.trim();
    final role = await _storageService.getRole();

    if (_formKey.currentState!.validate()) {
      if (!mounted) return;
      if (role == 'teacher') {
        context.read<ClassCloudBloc>().add(CreateClassEvent(
            code: code,
            title: title,
            description: description,
            teacherId: uid));
      } else {
        context.read<ClassCloudBloc>().add(JoinClassEvent(
              code: codeInput,
              uid: uid,
            ));
      }
    }
  }
}
