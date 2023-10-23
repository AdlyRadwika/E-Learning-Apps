import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/features/domain/entities/class/class.dart';
import 'package:final_project/features/presentation/pages/class/detail/class_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClassItem extends StatefulWidget {
  final Class? data;

  const ClassItem({
    super.key,
    required this.data,
  });

  @override
  State<ClassItem> createState() => _ClassItemState();
}

class _ClassItemState extends State<ClassItem> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Class Options');

  void _copyClassCode() {
    final data = widget.data;
    Clipboard.setData(ClipboardData(text: data?.code ?? 'ERROR'))
        .then((value) => context.showSnackBar(
              message:
                  "${data?.title}'s class code has been copied to your clipboard.",
            ));
  }

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MenuAnchor(
        childFocusNode: _buttonFocusNode,
        menuChildren: [
          MenuItemButton(
              onPressed: () => _copyClassCode(),
              child: const Text('Share Class'))
        ],
        builder: (context, controller, _) {
          return Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: theme.colorScheme.secondaryContainer,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onLongPress: () => _onMenuAnchorAction(controller),
                onDoubleTap: () => _onMenuAnchorAction(controller),
                onTap: () => Navigator.pushNamed(context, ClassDetailPage.route,
                    arguments: {
                      'data': widget.data,
                    }),
                child: Center(
                  child: Text(
                    widget.data?.title ?? "Unknown Class",
                    style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSecondaryContainer),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _onMenuAnchorAction(MenuController controller) {
    if (controller.isOpen) {
      controller.close();
    } else {
      controller.open();
    }
  }
}
