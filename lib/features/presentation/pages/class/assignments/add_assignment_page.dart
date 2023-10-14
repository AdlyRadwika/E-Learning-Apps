import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddAssignmentPage extends StatefulWidget {
  static const route = '/add-assignment';

  const AddAssignmentPage({super.key});

  @override
  State<AddAssignmentPage> createState() => _AddAssignmentPageState();
}

class _AddAssignmentPageState extends State<AddAssignmentPage> {
  final _titleC = TextEditingController();
  final _descriptionC = TextEditingController();
  final _deadlineC = TextEditingController();

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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
              onPressed: () => print, child: const Text('Submit')),
        ),
      ),
    );
  }
}
