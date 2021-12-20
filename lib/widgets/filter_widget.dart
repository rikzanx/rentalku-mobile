import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';

class FilterWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final void Function(bool) onTap;

  const FilterWidget({
    Key? key,
    required this.label,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 2,
          color: selected ? AppColor.green : Color(0xFFA0A0A0),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        child: Center(
          child: Text(
            label,
            style: AppStyle.regular2Text.copyWith(
              color: selected ? AppColor.green : Colors.black,
            ),
          ),
        ),
        onTap: () {
          print(label);
          onTap(!selected);
        },
      ),
    );
  }
}
