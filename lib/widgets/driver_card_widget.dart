import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/user.dart';

class DriverCardWidget extends StatelessWidget {
  final bool selected;
  final void Function()? onTap;
  final User user;

  const DriverCardWidget({
    Key? key,
    required this.onTap,
    required this.selected,
    required this.user
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
                    NetworkImage(assetURL+user.imageURL),
                radius: 20,
              ),
            ),
            SizedBox(height: 5),
            Text(
              user.name,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.regular2Text,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 12, color: AppColor.yellow),
                SizedBox(width: 2),
                Text(
                  user.rating.toString(),
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
