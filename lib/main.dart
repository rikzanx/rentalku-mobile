import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/router.dart' as router;
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/pages/undefined_page.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/providers/chat_provider.dart';
import 'package:rentalku/providers/dashboard_provider.dart';
import 'package:rentalku/providers/form_unit_provider.dart';
import 'package:rentalku/providers/order_provider.dart';
import 'package:rentalku/providers/password_provider.dart';
import 'package:rentalku/providers/search_units_provider.dart';
import 'package:rentalku/providers/ulasan_unit_provider.dart';
import 'package:rentalku/providers/sopir_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  timeago.setLocaleMessages('id', timeago.IdMessages());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => SearchUnitsProvider()),
        ChangeNotifierProvider(create: (context) => UlasanUnitProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => FormUnitProvider()),
        ChangeNotifierProvider(create: (context) => SopirProvider()),
        ChangeNotifierProvider(create: (context) => PasswordProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => MaterialApp(
        title: 'Rentalku',
        initialRoute: Routes.home,
        onGenerateRoute: router.generateRoute,
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedPage(
            name: settings.name.toString(),
          ),
        ),
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [
          const Locale('id'),
        ],
        theme: ThemeData(
          primaryColor: AppColor.green,
          backgroundColor: Colors.white,
          fontFamily: GoogleFonts.poppins().fontFamily,
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
            hintStyle: AppStyle.regular1Text.copyWith(
              color: Color(0xFF696969),
            ),
            errorStyle: AppStyle.regular2Text.copyWith(
              color: Colors.redAccent,
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColor.green,
            titleTextStyle: AppStyle.title1Text,
            titleSpacing: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: AppColor.yellow,
              onPrimary: Colors.white,
              elevation: 3,
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: AppStyle.title2Text,
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
              textStyle: AppStyle.title2Text,
            ),
          ),
        ),
      ),
    );
  }
}
