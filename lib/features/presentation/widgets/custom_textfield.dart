import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final TextInputType keyboardType;
  final String valueComparison;
  final bool isPassword;
  final bool isReadOnly;
  final bool isDone;
  final int maxLines;
  final Function(String value)? onChanged;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.valueComparison = "",
    this.onChanged,
    this.isReadOnly = false,
    this.isDone = false, this.maxLines = 1,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObsecure = true;

  bool _isValidEmailFormat(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      readOnly: widget.isReadOnly,
      controller: widget.controller,
      style: theme.textTheme.labelLarge?.copyWith(
        fontSize: 14,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill your ${widget.label.toLowerCase()}!';
        }
        if (widget.isPassword && value.length < 8) {
          return "${widget.label} should be at least 8 characters!";
        }
        if (widget.keyboardType == TextInputType.emailAddress &&
            !_isValidEmailFormat(value)) {
          return "Please fix your format email!";
        }
        final comparison = widget.valueComparison.trim();
        if (comparison.isNotEmpty && comparison != value) {
          return "${widget.label} is not the same!";
        }
        return null;
      },
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      inputFormatters: widget.keyboardType ==
              const TextInputType.numberWithOptions(decimal: false)
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      keyboardType: widget.keyboardType,
      textInputAction:
          widget.isDone ? TextInputAction.done : TextInputAction.next,
      obscureText: widget.isPassword
          ? _isObsecure
              ? true
              : false
          : false,
      decoration: InputDecoration(
          filled: true,
          labelText: widget.label,
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        _isObsecure = !_isObsecure;
                      },
                    );
                  },
                  child: Icon(
                    _isObsecure ? Icons.visibility : Icons.visibility_off,
                  ))
              : const SizedBox.shrink()),
    );
  }
}
