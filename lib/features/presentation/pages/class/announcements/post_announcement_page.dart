import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/common/services/uuid_service.dart';
import 'package:final_project/features/presentation/bloc/announcement_cloud/announcement_cloud_bloc.dart';
import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAnnouncementPage extends StatefulWidget {
  static const route = '/post-announcement';

  const PostAnnouncementPage(
      {super.key,
      required this.classCode,
      required this.contentText,
      required this.isUpdate,
      required this.announcementId});

  final String classCode;
  final String contentText;
  final String announcementId;
  final bool isUpdate;

  @override
  State<PostAnnouncementPage> createState() => _PostAnnouncementPageState();
}

class _PostAnnouncementPageState extends State<PostAnnouncementPage> {
  final _uuidService = locator<UuidService>();
  final _storageService = locator<SecureStorageService>();

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _postC;

  @override
  void initState() {
    super.initState();

    _postC = TextEditingController(text: widget.contentText.trim());
  }

  @override
  void dispose() {
    super.dispose();

    _postC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post Announcement'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: _postC,
                  label: 'Content',
                  icon: Icons.announcement,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocListener<AnnouncementCloudBloc, AnnouncementCloudState>(
            listener: (context, state) {
              if (state is InsertAnnouncementResult && state.isSuccess) {
                Navigator.pop(context);
                context.showSnackBar(
                    message: 'You have posted a new announcement!',
                    backgroundColor: Colors.green);
              } else if (state is InsertAnnouncementResult &&
                  !state.isSuccess) {
                context.showErrorSnackBar(
                  message: state.message,
                );
              }
              if (state is UpdateAnnouncementResult && state.isSuccess) {
                Navigator.pop(context);
                context.showSnackBar(
                    message: 'You have successfully updated the announcement!',
                    backgroundColor: Colors.green);
              } else if (state is UpdateAnnouncementResult &&
                  !state.isSuccess) {
                context.showErrorSnackBar(
                  message: state.message,
                );
              }
            },
            child: ElevatedButton(
                onPressed: () => _submit(), child: const Text('Submit')),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final content = _postC.text.trim();
    final announcementId = _uuidService.generateAnnouncementId();
    final teacherId = await _storageService.getUid();
    final classCode = widget.classCode.trim();

    if (_formKey.currentState!.validate()) {
      if (!mounted) return;
      if (widget.isUpdate) {
        context.read<AnnouncementCloudBloc>().add(UpdateAnnouncementEvent(
            content: content, id: widget.announcementId));
      } else {
        context.read<AnnouncementCloudBloc>().add(InsertAnnouncementEvent(
            announcementId: announcementId,
            teacherId: teacherId,
            content: content,
            classCode: classCode));
      }
    }
  }
}
