import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';

class DriverCardWidget extends StatelessWidget {
  final bool selected;
  final void Function()? onTap;

  const DriverCardWidget({
    Key? key,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      color: selected ? AppColor.lightGreen : Colors.white,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              elevation: 1,
              shape: CircleBorder(),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage("https://lorempixel.com/200/200/people/"),
                radius: 20,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Asep",
              style: AppStyle.regular2Text,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 12, color: AppColor.yellow),
                SizedBox(width: 2),
                Text(
                  "4.2",
                  style: AppStyle.smallText,
                ),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
