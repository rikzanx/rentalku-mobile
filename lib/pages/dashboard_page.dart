import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/pages/dashboard/home_page.dart';
import 'package:rentalku/pages/dashboard/my_booking_page.dart';
import 'package:rentalku/pages/dashboard/profil_page.dart';
import 'package:rentalku/providers/dashboard_provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller:
            Provider.of<DashboardProvider>(context, listen: false).controller,
        children: const [
          DashboardHomePage(),
          DashboardMyBookingPage(),
          DashboardProfilPage(),
        ],
        onPageChanged: (index) {
          Provider.of<DashboardProvider>(context, listen: false)
              .bottomNavIndex = index;
        },
      ),
      bottomNavigationBar: Consumer<DashboardProvider>(
        builder: (context, state, _) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: state.bottomNavIndex,
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
              label: "Beranda",
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
            state.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
