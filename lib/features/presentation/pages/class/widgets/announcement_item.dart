import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/common/util/bool_util.dart';
import 'package:final_project/features/domain/entities/announcement/announcement_content.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/announcements/post_announcement_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnoucementItem extends StatefulWidget {
  final AnnouncementContent? data;

  const AnnoucementItem({
    super.key,
    required this.data,
  });

  @override
  State<AnnoucementItem> createState() => _AnnoucementItemState();
}

class _AnnoucementItemState extends State<AnnoucementItem> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Class Options');
  void _onMenuAnchorAction(MenuController controller) {
    if (controller.isOpen) {
      controller.close();
    } else {
      controller.open();
    }
  }

  void _onUpdate() {
    final data = widget.data;
    Navigator.pushNamed(context, PostAnnouncementPage.route, arguments: {
      'classCode': data?.classCode ?? "-",
      'contentText': data?.content ?? "",
      'isUpdate': true,
      'announcementId': data?.id ?? "-"
    });
  }

  void _onDelete() {
    // final data = widget.data;
  }

  @override
  void dispose() {
    super.dispose();

    _buttonFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final owner = widget.data?.owner;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[300],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          owner?.imageUrl ?? AssetConts.imageUserDefault),
                      backgroundColor: Colors.grey,
                      radius: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(owner?.name ?? 'Teacher',
                            style: theme.textTheme.labelLarge),
                        Text(
                          DateTime.now().toString(),
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
                BlocBuilder<UserCloudBloc, UserCloudState>(
                  builder: (context, state) {
                    if (state is GetUserByIdResult && state.isSuccess) {
                      final role = state.user?.role;
                      return MenuAnchor(
                          childFocusNode: _buttonFocusNode,
                          menuChildren: [
                            MenuItemButton(
                                onPressed: () => _onUpdate(),
                                child: const Text('Edit Announcement')),
                            MenuItemButton(
                                onPressed: () => _onDelete(),
                                child: const Text(
                                  'Delete Announcement',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                )),
                          ],
                          builder: (context, controller, _) {
                            return IconButton(
                                onPressed: () =>
                                    BoolUtil.isTeacher(role: role ?? "-")
                                        ? _onMenuAnchorAction(controller)
                                        : null,
                                icon: const Icon(Icons.menu));
                          });
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            const Divider(),
            Text(
              widget.data?.content ??
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
            )
          ],
        ),
      ),
    );
  }
}
