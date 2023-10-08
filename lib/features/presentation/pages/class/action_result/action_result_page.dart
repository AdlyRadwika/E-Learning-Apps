import 'package:final_project/features/presentation/pages/class/action_result/widgets/action_form.dart';
import 'package:final_project/features/presentation/pages/class/action_result/widgets/action_result_appbar.dart';
import 'package:flutter/material.dart';

class ActionResultPage extends StatefulWidget {
  static const route = '/class-action';

  const ActionResultPage({super.key});

  @override
  State<ActionResultPage> createState() => _ActionResultPageState();
}

class _ActionResultPageState extends State<ActionResultPage> {
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
          child: ElevatedButton(
              onPressed: () => print, child: const Text("Submit")),
        ),
      ),
    );
  }
}
