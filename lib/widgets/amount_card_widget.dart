import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/styles.dart';

class AmountCardWidget extends StatelessWidget {
  final bool isSelected;
  final int amount;
  final void Function()? onTap;

  const AmountCardWidget({
    Key? key,
    required this.amount,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.hardEdge,
      color: isSelected ? AppColor.yellow : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            Helper.toIDR(amount),
            style: AppStyle.smallText.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
