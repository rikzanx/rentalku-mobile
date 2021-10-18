import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentalku/commons/styles.dart';

class TextFieldWithShadow extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final double height;
  final bool obscureText;
  final Color labelColor;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool enabled;

  const TextFieldWithShadow({
    Key? key,
    this.controller,
    this.height = 49,
    this.hintText,
    this.keyboardType,
    this.labelText,
    this.textInputAction,
    this.validator,
    this.obscureText = false,
    this.labelColor = Colors.white,
    this.prefixText,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (labelText != null)
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 4),
            child: Text(
              labelText!,
              style: AppStyle.labelText.copyWith(
                color: labelColor,
              ),
            ),
          ),
        Stack(
          children: [
            Material(
              elevation: 3,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: height,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                prefixText: prefixText,
                prefixStyle: AppStyle.regular1Text,
              ),
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              style: AppStyle.regular1Text,
              textInputAction: textInputAction,
              validator: validator,
              onChanged: onChanged,
              onTap: onTap,
              enabled: enabled,
            ),
          ],
        ),
      ],
    );
  }
}
