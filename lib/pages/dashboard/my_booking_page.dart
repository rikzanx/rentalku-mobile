import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/booking.dart';
import 'package:rentalku/providers/dashboard_provider.dart';
import 'package:rentalku/widgets/booking_card_widget.dart';

class DashboardMyBookingPage extends StatelessWidget {
  const DashboardMyBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardProvider(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text(
                "PesananKu",
                style: AppStyle.title2Text.copyWith(
                  color: AppColor.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      color: AppColor.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Consumer<DashboardProvider>(
                        builder: (context, dashboard, _) => InkWell(
                          child: Text(
                            "Sedang di pesan",
                            textAlign: TextAlign.center,
                            style: AppStyle.regular1Text.copyWith(
                              color: dashboard.myBookingIndex == 0
                                  ? AppColor.yellow
                                  : Colors.white,
                            ),
                          ),
                          onTap: () {
                            dashboard.myBookingIndex = 0;
                            dashboard.bookings = [];
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    child: Material(
                      color: AppColor.green,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Consumer<DashboardProvider>(
                        builder: (context, dashboard, _) => InkWell(
                          child: Text(
                            "Selesai",
                            textAlign: TextAlign.center,
                            style: AppStyle.regular1Text.copyWith(
                              color: dashboard.myBookingIndex == 1
                                  ? AppColor.yellow
                                  : Colors.white,
                            ),
                          ),
                          onTap: () {
                            dashboard.myBookingIndex = 1;
                            dashboard.bookings = List.generate(
                              4,
                              (index) => Booking(
                                id: 1,
                                name: "Toyota Innova Reborn",
                                description: "Compact MPV",
                                withDriver: true,
                                price: 500000,
                                imageURL: "https://i.imgur.com/vtUhSMq.png",
                                startDate: DateTime.now(),
                                endDate: DateTime.now().add(Duration(days: 2)),
                                address: "Jl. Anjasmoro No. 2, Waru, Sidoarjo",
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<DashboardProvider>(
              builder: (context, dashboard, _) {
                if (dashboard.bookings.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: 48),
                      Image.asset(
                        "assets/images/empty_order.png",
                        width: MediaQuery.of(context).size.width * 0.65,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Belum ada pesanan",
                        style: AppStyle.smallText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Ayo buruan pesan sekarang",
                        style: AppStyle.smallText.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: List.generate(
                      dashboard.bookings.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: BookingCardWidget(
                          booking: dashboard.bookings.elementAt(index),
                          onTap: () {},
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
