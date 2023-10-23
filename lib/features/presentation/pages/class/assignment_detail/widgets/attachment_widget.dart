import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/common/extensions/file.dart';
import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/extensions/strings.dart';
import 'package:final_project/features/domain/entities/assignment/submission.dart';
import 'package:final_project/features/presentation/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AttachmentWidget extends StatefulWidget {
  final Function(File file)? onUpload;
  final ThemeData theme;
  final Submission? data;

  const AttachmentWidget({
    super.key,
    required this.theme,
    required this.onUpload,
    required this.data,
  });

  @override
  State<AttachmentWidget> createState() => _AttachmentWidgetState();
}

class _AttachmentWidgetState extends State<AttachmentWidget> {
  File? _attachmentFile;
  bool _isLoading = false;

  Future<void> _showResultDialog() {
    return showResultDialog(context,
        isSuccess: false,
        labelContent:
            'The attachment should be in pdf file and the maximum size should be 1 MB. The last thing is you can only upload ONCE.',
        showCancelBtn: true,
        onPressed: _getPDFFile);
  }

  Future<void> _getPDFFile() async {
    setState(() {
      _isLoading = true;
    });
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    ).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });

    if (file != null) {
      final pickedFile = File(file.files.first.path ?? "-");
      final fileSize = pickedFile.lengthSync();

      if (fileSize < 1000000) {
        widget.onUpload!(pickedFile);
        setState(() {
          _attachmentFile = pickedFile;
        });
      } else {
        if (!mounted) return;
        context.showErrorSnackBar(
            message: 'The maximum size of the file is 1MB!');
      }
    }
  }

  Future<void> _launchUrl(String? url) async {
    final uri = Uri.tryParse(url ?? '-');
    if (await canLaunchUrl(uri!)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      context.showErrorSnackBar(
          message: "Your submission file couldn't be opened.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: widget.onUpload == null
              ? () => _launchUrl(widget.data?.fileUrl)
              : () => _showResultDialog(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: widget.data != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.attach_file, color: Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${widget.data?.fileName.truncateTo(15) ?? "..."} .pdf',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                : UnsubmittedAttachment(
                    isLoading: _isLoading,
                    attachmentFile: _attachmentFile,
                    widget: widget),
          ),
        ),
      ),
    );
  }
}

class UnsubmittedAttachment extends StatelessWidget {
  const UnsubmittedAttachment({
    super.key,
    required bool isLoading,
    required File? attachmentFile,
    required this.widget,
  })  : _isLoading = isLoading,
        _attachmentFile = attachmentFile;

  final bool _isLoading;
  final File? _attachmentFile;
  final AttachmentWidget widget;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : _attachmentFile == null
                ? Text(
                    'Add an attachment here',
                    style: widget.theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.attach_file, color: Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${_attachmentFile?.name.truncateTo(15) ?? "..."} .pdf',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ));
  }
}
