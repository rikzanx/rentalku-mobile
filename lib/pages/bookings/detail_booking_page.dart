import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/booking.dart';
import 'package:rentalku/providers/app_provider.dart';

class DetailBookingPage extends StatelessWidget {
  const DetailBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Booking booking = Booking(
      id: 1,
      name: "Toyota Innova Reborn",
      description: "Compact MPV",
      withDriver: true,
      price: 500000,
      imageURL: "https://i.imgur.com/vtUhSMq.png",
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 2)),
      address: "Jl. Anjasmoro No. 2, Waru, Sidoarjo",
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Detail Pemesanan"),
        titleTextStyle: AppStyle.title3Text.copyWith(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.network(booking.imageURL),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booking.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: AppStyle.regular1Text.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  booking.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.regular1Text.copyWith(
                                    color: Colors.grey[500],
                                  ),
                                ),
                                Text(
                                  "${booking.totalDays} hari",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.smallText.copyWith(
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Consumer<AppProvider>(
                        builder: (context, state, _) => Row(
                          children: [
                            Expanded(
                              child: Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(5),
                                clipBehavior: Clip.hardEdge,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "CAR RENT - Rentalku",
                                        style: AppStyle.smallText.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                          booking.withDriver
                                              ? "Dengan Sopir"
                                              : "Tanpa Sopir",
                                          style: AppStyle.smallText),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (state.isOwner) SizedBox(width: 6),
                            if (state.isOwner)
                              Expanded(
                                child: Material(
                                  elevation: 1,
                                  borderRadius: BorderRadius.circular(5),
                                  clipBehavior: Clip.hardEdge,
                                  color: AppColor.yellow,
                                  child: InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_pin, size: 20),
                                          Expanded(
                                            child: Text(
                                              "Lihat Lokasi Mobil",
                                              style: AppStyle.regular2Text
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.trackCar);
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Alamat", style: AppStyle.smallText),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.green,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Text(
                          booking.address,
                          style: AppStyle.smallText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Tanggal", style: AppStyle.smallText),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.green,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Text(
                          "${DateFormat("d MMMM yyyy", "id_ID").format(booking.startDate)} - ${DateFormat("d MMMM yyyy", "id_ID").format(booking.endDate)}",
                          style: AppStyle.smallText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Sopir", style: AppStyle.smallText),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.green,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Text(
                                "Asep",
                                style: AppStyle.smallText.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            flex: 1,
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColor.yellow,
                              clipBehavior: Clip.hardEdge,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    "Hubungi",
                                    textAlign: TextAlign.center,
                                    style: AppStyle.smallText.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("Total", style: AppStyle.smallText),
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(5),
                        clipBehavior: Clip.hardEdge,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "${Helper.toIDR(booking.price)} x ${booking.totalDays} Hari",
                                style: AppStyle.smallText.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text("Total ${Helper.toIDR(booking.totalPrice)}",
                                  style: AppStyle.smallText),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 6,
              color: Color(0xFFE0E0E0),
            ),
            SizedBox(height: 16),
            Text("Data Diri Pemesan", style: AppStyle.title3Text),
            Padding(
              padding: EdgeInsets.all(16),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Muhammad",
                        style: AppStyle.regular1Text.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "082335812487",
                        style: AppStyle.regular1Text.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Jl. Anjasmoro No. 2, Waru, Sidoarjo",
                        style: AppStyle.smallText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
