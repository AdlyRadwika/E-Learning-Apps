import 'package:final_project/common/util/bool_util.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/assignment_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/assignment_detail/assignment_detail_page.dart';
import 'package:final_project/features/presentation/pages/class/assignments/add_assignment_page.dart';
import 'package:final_project/features/presentation/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignmentItem extends StatefulWidget {
  final Assignment? data;

  const AssignmentItem({
    super.key,
    required this.data,
  });

  @override
  State<AssignmentItem> createState() => _AssignmentItemState();
}

class _AssignmentItemState extends State<AssignmentItem> {
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
    Navigator.pushNamed(context, AddAssignmentPage.route, arguments: {
      'data': data,
      'isEdit': true,
      'classCode': data?.classCode ?? "-",
    });
  }

  void _onDelete() {
    showResultDialog(
      context,
      isSuccess: false,
      showCancelBtn: true,
      labelContent: 'Are you sure you want to delete this assignment?',
      onPressed: () {
        context
            .read<AssignmentCloudBloc>()
            .add(DeleteAssignmentEvent(id: widget.data?.id ?? "-"));
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
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, AssignmentDetailPage.route,
            arguments: {
              'data': widget.data,
            }),
        trailing: BoolUtil.isTeacher(role: UserConfigUtil.role)
            ? MenuAnchor(
                childFocusNode: _buttonFocusNode,
                menuChildren: [
                  MenuItemButton(
                      onPressed: () => _onUpdate(),
                      child: const Text('Edit Assignment')),
                  MenuItemButton(
                      onPressed: () => _onDelete(),
                      child: const Text(
                        'Delete Assignment',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )),
                ],
                builder: (context, controller, _) {
                  return IconButton(
                      onPressed: () => _onMenuAnchorAction(controller),
                      icon: const Icon(Icons.more_vert));
                })
            : const SizedBox.shrink(),
        leading: const Icon(Icons.assignment),
        title: Text(
          widget.data?.title ?? "Unknown Assignment",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
            'Submit before ${DateUtil.formatDate(widget.data?.deadline ?? DateTime.now().toString())}'),
      ),
    );
  }
}
