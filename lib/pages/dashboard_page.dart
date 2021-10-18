import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/pages/dashboard/home_page.dart';
import 'package:rentalku/pages/dashboard/my_booking_page.dart';
import 'package:rentalku/pages/dashboard/profil_page.dart';
import 'package:rentalku/providers/dashboard_provider.dart';
import 'package:rentalku/commons/colors.dart';

final controller = PageController();

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<DashboardProvider>(
          builder: (context, dashboard, _) => PageView(
            controller: controller,
            children: [
              DashboardHomePage(),
              DashboardMyBookingPage(),
              DashboardProfilPage(),
            ],
            onPageChanged: (index) => dashboard.bottomNavIndex = index,
          ),
        ),
        bottomNavigationBar: Consumer<DashboardProvider>(
          builder: (context, dashboard, _) => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: dashboard.bottomNavIndex,
            selectedItemColor: AppColor.yellow,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: AppStyle.smallText,
            unselectedLabelStyle: AppStyle.smallText,
            backgroundColor: AppColor.green,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/home_icon.png',
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/home_icon_active.png',
                  height: 24,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/booking_icon.png',
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/booking_icon_active.png',
                  height: 24,
                ),
                label: "PesananKu",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/profil_icon.png',
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/profil_icon_active.png',
                  height: 24,
                ),
                label: "Profil",
              ),
            ],
            onTap: (index) {
              dashboard.bottomNavIndex = index;
              controller.jumpToPage(index);
            },
          ),
        ),
      ),
    );
  }
}
