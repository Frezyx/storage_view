import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storage_view/storage_view.dart';

class FilledTextField extends StatelessWidget {
  const FilledTextField({
    Key? key,
    required this.theme,
    this.hintText,
    this.controller,
    this.onTap,
    this.autoFocus = false,
    this.inputFormatters,
    this.prefix,
    this.keyboardType,
    this.validator,
    this.border,
    this.fillColor,
    this.suffix,
    this.textAlign = TextAlign.start,
    this.enabled,
  }) : super(key: key);

  final StorageViewTheme theme;
  final String? hintText;
  final TextEditingController? controller;
  final Function()? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final OutlineInputBorder? border;
  final Color? fillColor;
  final TextAlign textAlign;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardAppearance: Brightness.dark,
      controller: controller,
      textAlign: textAlign,
      enabled: enabled,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      onTap: onTap ?? () {},
      autofocus: autoFocus,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: outlinedInputDecoration(context),
    );
  }

  InputDecoration outlinedInputDecoration(BuildContext context) {
    final t = Theme.of(context);
    final startBorder = border ??
        OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(6),
        );
    return InputDecoration(
      prefix: prefix,
      suffix: suffix,
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.3),
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      floatingLabelStyle: TextStyle(
        color: t.primaryColor,
        fontWeight: FontWeight.w600,
      ),
      filled: true,
      fillColor: fillColor ?? theme.backgroundColor,
      focusColor: t.hintColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: startBorder,
      errorBorder: border ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.red),
          ),
      focusedBorder: border ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: t.primaryColor,
            ),
          ),
      enabledBorder: startBorder,
    );
  }
}
