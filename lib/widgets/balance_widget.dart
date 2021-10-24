import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';

class BalanceWidget extends StatelessWidget {
  final int balance;
  final bool enableTopUp;
  final EdgeInsets? padding;

  const BalanceWidget({
    Key? key,
    this.balance = 0,
    this.enableTopUp = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(
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
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  Helper.toIDR(balance),
                  style: GoogleFonts.poppins(fontSize: 10),
                )
              ],
            ),
            if (enableTopUp) Spacer(),
            if (enableTopUp)
              ElevatedButton(
                child: Text("Top Up"),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.topUp);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  primary: AppColor.green,
                  padding: EdgeInsets.all(0),
                  visualDensity: VisualDensity.compact,
                  textStyle: GoogleFonts.poppins(
                    fontSize: 10,
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
