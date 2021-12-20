import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/booking.dart';

class BookingCardWidget extends StatelessWidget {
  final Booking booking;
  final IconData? actionIcon;
  final String? actionText;
  final bool enableAction;
  final void Function()? actionOnTap;
  final void Function()? onTap;

  const BookingCardWidget({
    Key? key,
    required this.booking,
    this.actionIcon,
    this.actionOnTap,
    this.actionText,
    this.enableAction = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(assetURL+booking.unit.imageURL),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.unit.name,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: AppStyle.regular1Text.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      booking.unit.kategoriName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.regular1Text.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                    Text(
                      Helper.toIDR(booking.totalHarga) + "/ ${booking.durasi} Hari",
                      style: AppStyle.smallText.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.yellow,
                      ),
                    ),
                    Text(
                      booking.withDriver ? "Dengan Supir" : "Tanpa Supir",
                      style: AppStyle.smallText,
                    ),
                    if (enableAction) SizedBox(height: 5),
                    if (enableAction)
                      Material(
                        color: AppColor.yellow,
                        borderRadius: BorderRadius.circular(5),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: actionOnTap,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(actionIcon, size: 12, color: Colors.white),
                                SizedBox(width: 3),
                                Text(
                                  actionText!,
                                  style: AppStyle.smallText.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
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
