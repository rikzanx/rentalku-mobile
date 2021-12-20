import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/styles.dart';

class BalanceWidget extends StatelessWidget {
  final EdgeInsets? padding;
  final String actionName;
  final bool enableAction;
  final int balance;
  final void Function()? onPressed;

  const BalanceWidget({
    Key? key,
    this.actionName = "Isi Saldo",
    this.balance = 0,
    this.enableAction = true,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 0,
            ),
        child: Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              size: 24,
              color: AppColor.green,
            ),
            SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Saldo Anda",
                  style: AppStyle.smallText.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  Helper.toIDR(balance),
                  style: AppStyle.smallText,
                )
              ],
            ),
            if (enableAction) Spacer(),
            if (enableAction)
              ElevatedButton(
                child: Text(actionName),
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  primary: AppColor.green,
                  padding: EdgeInsets.all(0),
                  visualDensity: VisualDensity.compact,
                  textStyle: AppStyle.smallText.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
