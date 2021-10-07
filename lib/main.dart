import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/pages/auth/login_page.dart';
import 'package:rentalku/pages/auth/register_page.dart';
import 'package:rentalku/pages/home_page.dart';
import 'package:rentalku/pages/routes.dart';
import 'package:rentalku/providers/home-provider.dart';
import 'package:rentalku/styles/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'Provider and Routes',
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => HomePage(),
          Routes.login: (context) => LoginPage(),
          Routes.register: (context) => RegisterPage(),
        },
        theme: ThemeData(
          primaryColor: AppColor.theme,
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(width: 2, color: AppColor.theme),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(width: 2, color: AppColor.theme),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(width: 2, color: AppColor.theme),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColor.theme,
            titleTextStyle: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            titleSpacing: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: AppColor.theme,
              elevation: 0,
              padding: EdgeInsets.all(16),
              textStyle: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              primary: AppColor.theme,
              side: BorderSide(width: 2, color: AppColor.theme),
              padding: EdgeInsets.all(16),
              textStyle: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
