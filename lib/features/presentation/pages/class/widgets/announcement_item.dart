import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/common/util/bool_util.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/domain/entities/announcement/announcement_content.dart';
import 'package:final_project/features/presentation/bloc/announcement_cloud/announcement_cloud_bloc.dart';
import 'package:final_project/features/presentation/bloc/announcement_cloud/get_announcement/get_announcements_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/announcements/post_announcement_page.dart';
import 'package:final_project/features/presentation/pages/profile/other_profile_page.dart';
import 'package:final_project/features/presentation/widgets/custom_dialog.dart';
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
    showResultDialog(
      context,
      isSuccess: false,
      showCancelBtn: true,
      labelContent: 'Are you sure you want to delete this announcement?',
      onPressed: () {
        context
            .read<AnnouncementCloudBloc>()
            .add(DeleteAnnouncementEvent(id: widget.data?.id ?? "-"));
        context.read<GetAnnouncementsBloc>().add(GetAnnouncementsByClassEvent(
            classCode: widget.data?.classCode ?? "-"));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _buttonFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = widget.data;
    final owner = data?.owner;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: theme.colorScheme.primaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, OtherProfilePage.route,
                      arguments: {"uid": owner?.uid}),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            owner?.imageUrl ?? AssetConts.imageUserDefault),
                        backgroundColor: Colors.white,
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
                            DateUtil.formatDate(
                                data?.createdAt ?? DateTime.now().toString()),
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                            return BoolUtil.isTeacher(role: role ?? "-")
                                ? IconButton(
                                    onPressed: () =>
                                        _onMenuAnchorAction(controller),
                                    icon: const Icon(Icons.more_vert))
                                : const SizedBox.shrink();
                          });
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            Divider(
              color: theme.colorScheme.onPrimaryContainer,
            ),
            Text(
              data?.content ??
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
            )
          ],
        ),
      ),
    );
  }
}
