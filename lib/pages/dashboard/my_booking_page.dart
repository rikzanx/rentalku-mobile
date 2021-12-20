import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/booking.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/providers/dashboard_provider.dart';
import 'package:rentalku/widgets/booking_card_widget.dart';

class DashboardMyBookingPage extends StatelessWidget {
  const DashboardMyBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = Provider.of<AppProvider>(context,listen: false).isUser;
    final isOwner = Provider.of<AppProvider>(context,listen: false).isOwner;
    final isDriver = Provider.of<AppProvider>(context,listen: false).isDriver;
    if(isUser){
      final model = Provider.of<DashboardProvider>(context,listen: false).getMyBookings();
      final model2 = Provider.of<DashboardProvider>(context,listen: false).getMyBookingsDone();
    }else if(isOwner){
      final model = Provider.of<DashboardProvider>(context,listen: false).getPemilikBookings();
      final model2 = Provider.of<DashboardProvider>(context,listen: false).getPemilikBookingsDone();
    }else{
      final model = Provider.of<DashboardProvider>(context,listen: false).getDriverBookings();
      final model2 = Provider.of<DashboardProvider>(context,listen: false).getDriverBookingsDone();
    }
    return ListView(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        AppBar(
          title: Text(
            "PesananKu",
            style: AppStyle.title1Text.copyWith(
              color: AppColor.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Material(
                color: AppColor.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                child: Consumer<AppProvider>(
                  builder: (context,app,_) {
                    return Consumer<DashboardProvider>(
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
                        onTap: () async{
                          if(app.isUser){
                            dashboard.getMyBookings();
                          }else if(app.isOwner){
                            dashboard.getPemilikBookings();
                          }else{
                            dashboard.getDriverBookings();
                          }
                          dashboard.myBookingIndex = 0;
                          dashboard.notifyListeners();
                        },
                      ),
                    );
                  }
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
                child: Consumer<AppProvider>(
                  builder: (context,app,_) {
                    return Consumer<DashboardProvider>(
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
                          if(app.isUser){
                            dashboard.getMyBookingsDone();
                          }else if(app.isOwner){
                            dashboard.getPemilikBookingsDone();
                          }else{
                            dashboard.getDriverBookingsDone();
                          }
                          dashboard.myBookingIndex = 1;
                          dashboard.notifyListeners();
                        },
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Consumer<AppProvider>(
          builder:(context,app,_){
            return Consumer<DashboardProvider>(
              builder: (context, dashboard, _) {
                if(dashboard.homeState == HomeState.Loading){
                  return Center(child: CircularProgressIndicator(color: AppColor.green,),);
                }
                if(app.isUser){
                  if(dashboard.myBookingIndex == 0){
                  //page pesanan proses
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
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Consumer<AppProvider>(
                              builder: (context, state, _) => BookingCardWidget(
                                booking: dashboard.bookings.elementAt(index),
                                onTap: ()async{
                                  print(dashboard.bookings.elementAt(index).id);
                                  if(dashboard.bookings.elementAt(index).withDriver){
                                    dashboard.getPengemudi(dashboard.bookings.elementAt(index).id);
                                    dashboard.notifyListeners();
                                  }
                                  Navigator.pushNamed(context, Routes.detailBooking,arguments: dashboard.bookings.elementAt(index));
                                },
                                actionIcon: Icons.phone,
                                actionText: state.isUser
                                    ? "Hubungi Pemilik"
                                    : state.isOwner
                                        ? "Hubungi Pemesan"
                                        : "Hubungi Penyewa",
                                actionOnTap: () async{
                                  if (state.isUser) {
                                    if(dashboard.bookings.elementAt(index).isDoneRating){
                                      Navigator.pushNamed(context, Routes.chats);
                                    }else{
                                      // if(dashboard.bookings.elementAt(index).withDriver){
                                      //   dashboard.getPengemudi(dashboard.bookings.elementAt(index).id);
                                      //   dashboard.notifyListeners();
                                      // }
                                      // Navigator.pushNamed(context, Routes.addReviewPage,arguments: dashboard.bookings.elementAt(index));
                                      Navigator.pushNamed(context, Routes.chats);
                                    }
                                  } else {
                                    Navigator.pushNamed(context, Routes.chats);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }else{
                    //page pesanan selesai
                    if (dashboard.bookingsDone.isEmpty) {
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
                          dashboard.bookingsDone.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Consumer<AppProvider>(
                              builder: (context, state, _) => BookingCardWidget(
                                booking: dashboard.bookingsDone.elementAt(index),
                                onTap: () async{
                                  if(dashboard.bookingsDone.elementAt(index).withDriver){
                                    dashboard.getPengemudi(dashboard.bookingsDone.elementAt(index).id);
                                    dashboard.notifyListeners();
                                  }
                                  Navigator.pushNamed(context, Routes.detailBooking,
                                    arguments: dashboard.bookingsDone.elementAt(index)
                                  );
                                },
                                actionIcon: state.isUser ? Icons.star : Icons.phone,
                                enableAction: state.isUser? dashboard.bookingsDone.elementAt(index).isDoneRating? false:true: false,
                                actionText: state.isUser
                                    ? "Beri Nilai"
                                    : state.isOwner
                                        ? "Hubungi Pemesan"
                                        : "Hubungi Penyewa",
                                actionOnTap: () async{
                                  if (state.isUser) {
                                    if(dashboard.bookingsDone.elementAt(index).isDoneRating){
                                      Navigator.pushNamed(context, Routes.chats);
                                    }else{
                                      if(dashboard.bookingsDone.elementAt(index).withDriver){
                                        dashboard.getPengemudi(dashboard.bookingsDone.elementAt(index).id);
                                        dashboard.notifyListeners();
                                      }
                                      Navigator.pushNamed(context, Routes.addReviewPage,arguments: dashboard.bookingsDone.elementAt(index));
                                    }
                                  } else {
                                    Navigator.pushNamed(context, Routes.viewChat);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                }else if(app.isOwner){
                  if(dashboard.myBookingIndex == 0){
                    //page pesanan proses
                    if (dashboard.pemilikBookings.isEmpty) {
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
                          dashboard.pemilikBookings.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Consumer<AppProvider>(
                              builder: (context, state, _) => BookingCardWidget(
                                booking: dashboard.pemilikBookings.elementAt(index),
                                onTap: ()async{
                                  print(dashboard.pemilikBookings.elementAt(index).id);
                                  if(dashboard.pemilikBookings.elementAt(index).withDriver){
                                    dashboard.getPengemudi(dashboard.pemilikBookings.elementAt(index).id);
                                    dashboard.notifyListeners();
                                  }
                                  Navigator.pushNamed(context, Routes.detailBooking,arguments: dashboard.pemilikBookings.elementAt(index));
                                },
                                actionIcon: Icons.phone,
                                actionText: state.isUser
                                    ? "Hubungi Pemilik"
                                    : state.isOwner
                                        ? "Hubungi Pemesan"
                                        : "Hubungi Penyewa",
                                actionOnTap: () async{
                                  if (state.isUser) {
                                    if(dashboard.pemilikBookings.elementAt(index).isDoneRating){
                                      Navigator.pushNamed(context, Routes.chats);
                                    }else{
                                      if(dashboard.pemilikBookings.elementAt(index).withDriver){
                                        dashboard.getPengemudi(dashboard.pemilikBookings.elementAt(index).id);
                                        dashboard.notifyListeners();
                                      }
                                      Navigator.pushNamed(context, Routes.addReviewPage,arguments: dashboard.pemilikBookings.elementAt(index));
                                    }
                                  } else {
                                    Navigator.pushNamed(context, Routes.chats);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }else{
                    //page pesanan selesai
                    if (dashboard.pemilikBookingsDone.isEmpty) {
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
                          dashboard.pemilikBookingsDone.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Consumer<AppProvider>(
                              builder: (context, state, _) => BookingCardWidget(
                                booking: dashboard.pemilikBookingsDone.elementAt(index),
                                onTap: () async{
                                  if(dashboard.pemilikBookingsDone.elementAt(index).withDriver){
                                    dashboard.getPengemudi(dashboard.pemilikBookingsDone.elementAt(index).id);
                                    dashboard.notifyListeners();
                                  }
                                  Navigator.pushNamed(context, Routes.detailBooking,
                                    arguments: dashboard.pemilikBookingsDone.elementAt(index)
                                  );
                                },
                                actionIcon: state.isUser ? Icons.star : Icons.phone,
                                enableAction: state.isUser? dashboard.pemilikBookingsDone.elementAt(index).isDoneRating? false:true: false,
                                actionText: state.isUser
                                    ? "Beri Nilai"
                                    : state.isOwner
                                        ? "Hubungi Pemesan"
                                        : "Hubungi Penyewa",
                                actionOnTap: () async{
                                  if (state.isUser) {
                                    if(dashboard.pemilikBookingsDone.elementAt(index).isDoneRating){
                                      Navigator.pushNamed(context, Routes.chats);
                                    }else{
                                      if(dashboard.pemilikBookingsDone.elementAt(index).withDriver){
                                        dashboard.getPengemudi(dashboard.pemilikBookingsDone.elementAt(index).id);
                                        dashboard.notifyListeners();
                                      }
                                      Navigator.pushNamed(context, Routes.addReviewPage,arguments: dashboard.pemilikBookingsDone.elementAt(index));
                                    }
                                  } else {
                                    Navigator.pushNamed(context, Routes.viewChat);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                }else{
                  if(dashboard.myBookingIndex == 0){
                    //page pesanan proses
                    if (dashboard.driverBookings.isEmpty) {
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
                          dashboard.driverBookings.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Consumer<AppProvider>(
                              builder: (context, state, _) => BookingCardWidget(
                                booking: dashboard.driverBookings.elementAt(index),
                                onTap: ()async{
                                  print(dashboard.driverBookings.elementAt(index).id);
                                  if(dashboard.driverBookings.elementAt(index).withDriver){
                                    dashboard.getPengemudi(dashboard.driverBookings.elementAt(index).id);
                                    dashboard.notifyListeners();
                                  }
                                  Navigator.pushNamed(context, Routes.detailBooking,arguments: dashboard.driverBookings.elementAt(index));
                                },
                                actionIcon: Icons.phone,
                                actionText: state.isUser
                                    ? "Hubungi Pemilik"
                                    : state.isOwner
                                        ? "Hubungi Pemesan"
                                        : "Hubungi Penyewa",
                                actionOnTap: () async{
                                  if (state.isUser) {
                                    if(dashboard.driverBookings.elementAt(index).isDoneRating){
                                      Navigator.pushNamed(context, Routes.chats);
                                    }else{
                                      if(dashboard.driverBookings.elementAt(index).withDriver){
                                        dashboard.getPengemudi(dashboard.driverBookings.elementAt(index).id);
                                        dashboard.notifyListeners();
                                      }
                                      Navigator.pushNamed(context, Routes.addReviewPage,arguments: dashboard.driverBookings.elementAt(index));
                                    }
                                  } else {
                                    Navigator.pushNamed(context, Routes.chats);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }else{
                    //page pesanan selesai
                    if (dashboard.driverBookingsDone.isEmpty) {
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
                          dashboard.driverBookingsDone.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Consumer<AppProvider>(
                              builder: (context, state, _) => BookingCardWidget(
                                booking: dashboard.driverBookingsDone.elementAt(index),
                                onTap: () async{
                                  if(dashboard.driverBookingsDone.elementAt(index).withDriver){
                                    dashboard.getPengemudi(dashboard.driverBookingsDone.elementAt(index).id);
                                    dashboard.notifyListeners();
                                  }
                                  Navigator.pushNamed(context, Routes.detailBooking,
                                    arguments: dashboard.driverBookingsDone.elementAt(index)
                                  );
                                },
                                actionIcon: state.isUser ? Icons.star : Icons.phone,
                                enableAction: state.isUser? dashboard.driverBookingsDone.elementAt(index).isDoneRating? false:true: false,
                                actionText: state.isUser
                                    ? "Beri Nilai"
                                    : state.isOwner
                                        ? "Hubungi Pemesan"
                                        : "Hubungi Penyewa",
                                actionOnTap: () async{
                                  if (state.isUser) {
                                    if(dashboard.driverBookingsDone.elementAt(index).isDoneRating){
                                      Navigator.pushNamed(context, Routes.chats);
                                    }else{
                                      if(dashboard.driverBookingsDone.elementAt(index).withDriver){
                                        dashboard.getPengemudi(dashboard.driverBookingsDone.elementAt(index).id);
                                        dashboard.notifyListeners();
                                      }
                                      Navigator.pushNamed(context, Routes.addReviewPage,arguments: dashboard.driverBookingsDone.elementAt(index));
                                    }
                                  } else {
                                    Navigator.pushNamed(context, Routes.viewChat);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                }
              },
            );
          } ,),
        
      ],
    );
  }
}
