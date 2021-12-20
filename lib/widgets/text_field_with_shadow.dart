import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentalku/commons/colors.dart';
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
  final obscureText;
  final bool withShowPassword;
  final double height;
  final void Function()? onTap;
  final void Function()? onPressed;
  final void Function()? onEditingComplete;
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
    this.withShowPassword = false,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.prefixText,
    this.suffixText,
    this.textInputAction,
    this.validator,
    this.onPressed,
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
              onEditingComplete: onEditingComplete,
              controller: controller,
              initialValue: initialValue,
              obscureText: obscureText,
              decoration: (withShowPassword)?
              InputDecoration(
                hintText: hintText,
                prefixText: prefixText,
                prefixStyle: AppStyle.regular1Text,
                suffixText: suffixText,
                suffixStyle: AppStyle.regular1Text,
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    obscureText
                    ? Icons.visibility
                    : Icons.visibility_off,
                    color: AppColor.green,
                    ),
                  onPressed:onPressed,
                  ),
                ):InputDecoration(
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
