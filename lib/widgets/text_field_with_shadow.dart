import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentalku/commons/styles.dart';

class TextFieldWithShadow extends StatelessWidget {
  final Color labelColor;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? initialValue;
  final String? labelText;
  final String? prefixText;
  final String? suffixText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool enabled;
  final bool obscureText;
  final double height;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const TextFieldWithShadow({
    Key? key,
    this.controller,
    this.enabled = true,
    this.height = 49,
    this.hintText,
    this.initialValue,
    this.inputFormatters,
    this.keyboardType,
    this.labelColor = Colors.white,
    this.labelText,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.prefixText,
    this.suffixText,
    this.textInputAction,
    this.validator,
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
              initialValue: initialValue,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                prefixText: prefixText,
                prefixStyle: AppStyle.regular1Text,
                suffixText: suffixText,
                suffixStyle: AppStyle.regular1Text,
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
