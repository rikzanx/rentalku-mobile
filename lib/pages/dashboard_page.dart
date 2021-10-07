import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/providers/dashboard_provider.dart';
import 'package:rentalku/styles/colors.dart';

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
              Center(child: Text("Home")),
              Center(child: Text("MyBooking")),
              Center(child: Text("Chat")),
              Center(child: Text("Profil")),
            ],
            onPageChanged: (index) => dashboard.bottomNavIndex = index,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: dashboard.bottomNavIndex,
            selectedItemColor: AppColor.theme,
            selectedLabelStyle: GoogleFonts.montserrat(fontSize: 10),
            unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 10),
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
