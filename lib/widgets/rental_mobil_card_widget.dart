import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/unit.dart';

class UnitCardWidget extends StatelessWidget {
  final Unit unit;
  final void Function()? onTap;

  const UnitCardWidget({
    Key? key,
    required this.onTap,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(5),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Image.network(unit.imageURL),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unit.name,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: AppStyle.regular1Text.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      unit.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.regular1Text,
                    ),
                    // Text(
                    //   unit.withDriver ? "" : "",
                    //   style: AppStyle.smallText,
                    // ),
                    Text(
                      "Harga Mulai Dari",
                      style: AppStyle.smallText.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      Helper.toIDR(unit.price) + "/Hari",
                      style: AppStyle.smallText.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.yellow,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.star, size: 12, color: AppColor.yellow),
                      SizedBox(width: 2),
                      Text(
                        unit.rating.toString(),
                        style: AppStyle.smallText,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.people, size: 12, color: AppColor.green),
                      SizedBox(width: 2),
                      Text(
                        unit.capacity.toString(),
                        style: AppStyle.smallText,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
