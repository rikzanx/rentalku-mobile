import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/pages/auth/login_page.dart';
import 'package:rentalku/pages/auth/register_page.dart';
import 'package:rentalku/pages/dashboard_page.dart';
import 'package:rentalku/pages/welcome_page.dart';
import 'package:rentalku/pages/profil/update_password_page.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/providers/welcome_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WelcomeProvider()),
      ],
      child: MaterialApp(
        title: 'Provider and Routes',
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => HomePage(),
          Routes.login: (context) => LoginPage(),
          Routes.register: (context) => RegisterPage(),
          Routes.dashboard: (context) => DashboardPage(),
          Routes.updatePassword: (context) => UpdatePasswordPage(),
        },
        theme: ThemeData(
          primaryColor: AppColor.green,
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            hintStyle: AppStyle.regularText.copyWith(
              color: Color(0xFF696969),
            ),
            errorStyle: AppStyle.regularText.copyWith(
              fontSize: 12,
              height: 1,
              color: Colors.redAccent,
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColor.green,
            titleTextStyle: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            titleSpacing: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: AppColor.yellow,
              elevation: 3,
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              primary: AppColor.green,
              side: BorderSide(width: 2, color: AppColor.green),
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
