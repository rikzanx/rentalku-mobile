import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';

class FilterShadowWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final void Function(bool) onTap;

  const FilterShadowWidget({
    Key? key,
    required this.label,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      clipBehavior: Clip.hardEdge,
      color: selected ? AppColor.yellow : Colors.white,
      child: InkWell(
        child: Center(
          child: Text(
            label,
            style: AppStyle.regular2Text.copyWith(
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
        onTap: () {
          onTap(!selected);
        },
      ),
    );
  }
}
