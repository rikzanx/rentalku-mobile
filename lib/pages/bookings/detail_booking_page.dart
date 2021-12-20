import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/booking.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/providers/dashboard_provider.dart';

class DetailBookingPage extends StatelessWidget {
  final Booking booking;
  const DetailBookingPage({Key? key,required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
      body: ListView(
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
                          child: Image.network(assetURL+booking.unit.imageURL),
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
                                booking.unit.kategoriName,
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
                    Row(
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "CAR RENT - ${booking.pemilik.name}",
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
                        Consumer<AppProvider>(
                          builder: (context, state, _) =>
                              state.isOwner ? SizedBox(width: 6) : SizedBox(),
                        ),
                        Consumer<AppProvider>(
                          builder: (context, state, _) => state.isOwner
                              ? Expanded(
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
                                        Navigator.pushNamed(
                                            context, Routes.trackCar,
                                            arguments: booking.unit);
                                      },
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ),
                        Consumer<AppProvider>(
                          builder: (context, state, _) =>
                              state.isDriver ? SizedBox(width: 6) : SizedBox(),
                        ),
                        Consumer<AppProvider>(
                          builder: (context, state, _) => state.isDriver
                              ? Expanded(
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
                                        child: Text(
                                          "Hubungi Pemilik",
                                          style: AppStyle.regular2Text.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.chats);
                                      },
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ),
                      ],
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
                    if(booking.withDriver)SizedBox(height: 10),
                    if(booking.withDriver)Text("Sopir", style: AppStyle.smallText),
                    if(booking.withDriver) Row(
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
                            child: Consumer<DashboardProvider>(
                              builder: (context,state,_) {
                                if(state.homeState == HomeState.Loading){
                                  return Center(child: CircularProgressIndicator(),);
                                }
                                if(state.homeState == HomeState.Error){
                                  return Center(child:Text(defaultErrorText));
                                }
                                return Text(
                                  state.pengemudi!.name,
                                  style: AppStyle.smallText.copyWith(
                                    color: Colors.white,
                                  ),
                                );
                              }
                            ),
                          ),
                        ),
                        Consumer<AppProvider>(
                          builder: (context, state, _) =>
                              state.isDriver ? SizedBox() : SizedBox(width: 6),
                        ),
                        Consumer<AppProvider>(
                          builder: (context, state, _) => state.isDriver
                              ? SizedBox()
                              : Expanded(
                                  flex: 1,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.yellow,
                                    clipBehavior: Clip.hardEdge,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.chats);
                                      },
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
                        ),
                      ],
                    ),
                    Consumer<AppProvider>(
                      builder: (context, state, _) =>
                          state.isDriver ? SizedBox() : SizedBox(height: 10),
                    ),
                    Consumer<AppProvider>(
                      builder: (context, state, _) => state.isDriver
                          ? SizedBox()
                          : Text("Total", style: AppStyle.smallText),
                    ),
                    Consumer<AppProvider>(
                      builder: (context, state, _) => state.isDriver
                          ? SizedBox()
                          : Material(
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
                                      "${Helper.toIDR(booking.unit.price)} x ${booking.totalDays} Hari",
                                      style: AppStyle.smallText.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                        "Total ${Helper.toIDR(booking.totalPrice)}",
                                        style: AppStyle.smallText),
                                  ],
                                ),
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
          Align(
            alignment: Alignment.center,
            child: Text("Data Diri Pemesan", style: AppStyle.title3Text),
          ),
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
                      booking.name,
                      style: AppStyle.regular1Text.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      booking.telp,
                      style: AppStyle.regular1Text.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      booking.address,
                      style: AppStyle.smallText,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
