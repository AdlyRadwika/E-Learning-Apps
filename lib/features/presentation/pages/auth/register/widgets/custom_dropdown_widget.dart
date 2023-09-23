import 'package:flutter/material.dart';

enum Roles {
  student('Student'),
  teacher('Teacher');

  const Roles(this.label);
  final String label;
}

class CustomDropdownWidget extends StatefulWidget {
  const CustomDropdownWidget({
    super.key,
    required this.dynamicWidth,
    required this.roleC,
  });

  final double dynamicWidth;
  final TextEditingController roleC;

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  final List<DropdownMenuEntry<Roles>> roleEntries =
      <DropdownMenuEntry<Roles>>[];

  void _initRoleEntries() {
    for (final Roles role in Roles.values) {
      roleEntries.add(DropdownMenuEntry(value: role, label: role.label));
    }
  }

  @override
  void initState() {
    super.initState();

    _initRoleEntries();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: widget.dynamicWidth * 0.92,
      inputDecorationTheme: const InputDecorationTheme(filled: true),
      dropdownMenuEntries: roleEntries,
      controller: widget.roleC,
      label: const Text('Role'),
    );
  }
}
