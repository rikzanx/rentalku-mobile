import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/pages/dashboard/chat_page.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
      ],
      child: Consumer<DashboardProvider>(
        builder: (context, dashboard, _) => Scaffold(
          backgroundColor: Colors.white,
          body: PageView(
            controller: controller,
            children: [
              DashboardHomePage(),
              DashboardMyBookingPage(),
              DashboardChatPage(),
              DashboardProfilPage(),
            ],
            onPageChanged: (index) => dashboard.bottomNavIndex = index,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: dashboard.bottomNavIndex,
            selectedItemColor: AppColor.green,
            selectedLabelStyle: GoogleFonts.poppins(fontSize: 10),
            unselectedLabelStyle: GoogleFonts.poppins(fontSize: 10),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/home_icon.png', height: 24),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/booking_icon.png', height: 24),
                label: "My Booking",
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/chat_icon.png', height: 24),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/profil_icon.png', height: 24),
                label: "Profil",
              ),
            ],
            onTap: (index){
              dashboard.bottomNavIndex = index;
              controller.jumpToPage(index);
            },
          ),
        )
      ),
    );
  }
}
