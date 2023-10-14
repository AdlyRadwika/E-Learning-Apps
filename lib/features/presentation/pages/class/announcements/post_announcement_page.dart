import 'package:final_project/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class PostAnnouncementPage extends StatefulWidget {
  static const route = '/post-announcement';

  const PostAnnouncementPage({super.key});

  @override
  State<PostAnnouncementPage> createState() => _PostAnnouncementPageState();
}

class _PostAnnouncementPageState extends State<PostAnnouncementPage> {
  final _postC = TextEditingController();

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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
              onPressed: () => print, child: const Text('Submit')),
        ),
      ),
    );
  }
}
