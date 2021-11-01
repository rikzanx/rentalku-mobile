import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentalku/commons/styles.dart';

class TextFieldUploadWithShadow extends StatelessWidget {
  TextEditingController _defaultController = TextEditingController();
  ValueNotifier<File?> _image = ValueNotifier(null);
  final Color labelColor;
  final Icon prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final double height;
  final void Function()? onTap;
  final void Function(File)? onFileChanged;
  final void Function(String)? onChanged;

  TextFieldUploadWithShadow({
    Key? key,
    this.controller,
    this.height = 49,
    this.hintText,
    this.inputFormatters,
    this.keyboardType,
    this.labelColor = Colors.white,
    this.labelText,
    this.obscureText = false,
    this.onChanged,
    this.onFileChanged,
    this.onTap,
    this.prefixIcon = const Icon(Icons.image),
    this.prefixText,
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
            InkWell(
              borderRadius: BorderRadius.circular(20),
              child: TextFormField(
                controller: controller ?? _defaultController,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: prefixIcon,
                ),
                inputFormatters: inputFormatters,
                keyboardType: keyboardType,
                style: AppStyle.regular1Text,
                textInputAction: textInputAction,
                validator: validator,
                onChanged: onChanged,
                onTap: onTap,
                enabled: false,
              ),
              onTap: () => pickImage(context),
            ),
          ],
        ),
      ],
    );
  }

  void getImage(ImageSource media) async {
    XFile? img = await ImagePicker().pickImage(source: media);
    if (img != null) {
      _image.value = File(img.path);
      (controller ?? _defaultController).text = img.name;
      if (onFileChanged != null) onFileChanged!(_image.value!);
    }
  }

  void pickImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("Silahkan pilih media"),
        content: Container(
          height: MediaQuery.of(context).size.height / 6,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 5),
                    Text("Galeri"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(width: 5),
                    Text("Kamera"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
