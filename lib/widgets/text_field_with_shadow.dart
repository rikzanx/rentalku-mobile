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
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                prefixText: prefixText,
                prefixStyle: AppStyle.regularText,
              ),
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              style: AppStyle.regularText,
              textInputAction: textInputAction,
              validator: validator,
            ),
          ],
        ),
      ],
    );
  }
}
