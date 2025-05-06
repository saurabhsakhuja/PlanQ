import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final bool? enabled;
  final int? maxLines;
  final ValueNotifier<bool>? obscureNotifier;
  final bool showLabel; // New parameter

  const CommonTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.inputType,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.obscureNotifier,
    this.showLabel = true, // Default value is true
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ValueListenableBuilder<bool>(
        valueListenable: obscureNotifier ?? ValueNotifier(obscureText),
        builder: (context, isObscured, child) {
          return TextFormField(
            controller: controller,
            obscureText: isObscured,
            keyboardType: inputType,
            validator: validator,
            enabled: enabled,
            maxLines: maxLines,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              labelText: showLabel ? label : null, // Show label conditionally
              hintText:
                  showLabel
                      ? null
                      : label, // Show label as hint if not showing label
              prefixIcon: Icon(icon, color: ColorConstant.primaryColor),
              filled: true,
              fillColor: Colors.grey[100],
              suffixIcon:
                  obscureNotifier != null
                      ? IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          obscureNotifier!.value = !obscureNotifier!.value;
                        },
                      )
                      : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorConstant.primaryColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
