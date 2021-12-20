import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/styles.dart';

class SupirButtonWidget extends StatelessWidget {
  final bool active;
  final String title;
  final void Function()? onPressed;

  const SupirButtonWidget({
    Key? key,
    this.active = false,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        child: Text(
          title,
          style: TextStyle(color: (active)?Colors.white:AppColor.green),
          ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: AppColor.green,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: AppColor.green),
          ),
          primary: (active)?AppColor.green:Colors.white,
          padding: EdgeInsets.all(0),
          visualDensity: VisualDensity.compact,
          textStyle: AppStyle.smallText.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
