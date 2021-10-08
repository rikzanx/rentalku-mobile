import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BalanceWidget extends StatelessWidget {
  final int balance;

  const BalanceWidget({Key? key, this.balance = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp. ",
      decimalDigits: 0,
    );

    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  formatCurrency.format(balance),
                  style: GoogleFonts.poppins(fontSize: 10),
                )
              ],
            ),
            ElevatedButton(
              child: Text("Top Up"),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
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
