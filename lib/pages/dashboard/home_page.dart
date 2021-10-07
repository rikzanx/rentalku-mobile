import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentalku/widgets/balance_widget.dart';
import 'package:rentalku/widgets/promo_card_widget.dart';

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/rentalku.png", height: 16),
                Ink(
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset("assets/images/cart_icon.png", width: 22),
                    padding: EdgeInsets.all(0),
                    splashRadius: 24,
                  ),
                  decoration: ShapeDecoration(
                    color: Color.fromARGB(51, 0, 122, 102),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Nama User
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Halo,",
                        style: GoogleFonts.montserrat(fontSize: 13),
                      ),
                      Text(
                        "Muhammad",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                // Saldo
                Expanded(
                  child: BalanceWidget(balance: 500000),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Form(
              child: Material(
                color: Colors.white,
                elevation: 1,
                borderRadius: BorderRadius.circular(5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search on RentalKu",
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                        ),
                        textInputAction: TextInputAction.search,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom username wajib diisi';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(4, 4, 8, 4),
                      child: Icon(Icons.search, size: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => Material(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  elevation: 1,
                  child: Ink(
                    width: (MediaQuery.of(context).size.width - 56) / 4,
                    height: (MediaQuery.of(context).size.width - 56) / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://lorempixel.com/300/200/transport"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 14,
            color: Colors.grey[300],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              "Promotion for you",
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 2),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 4,
                    right: index == 4 ? 16 : 4,
                  ),
                  child: PromoCardWidget(
                    url: "https://lorempixel.com/300/200/transport",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
