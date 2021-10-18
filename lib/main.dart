import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/commons/router.dart' as router;
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/pages/undefined_page.dart';
import 'package:rentalku/providers/chat_provider.dart';
import 'package:rentalku/providers/dashboard_provider.dart';
import 'package:rentalku/providers/top_up_provider.dart';
import 'package:rentalku/providers/app_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'Provider and Routes',
        initialRoute: Routes.home,
        onGenerateRoute: router.generateRoute,
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedPage(
            name: settings.name.toString(),
          ),
        ),
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
            hintStyle: AppStyle.regular1Text.copyWith(
              color: Color(0xFF696969),
            ),
            errorStyle: AppStyle.regular1Text.copyWith(
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
              onPrimary: Colors.white,
              elevation: 3,
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
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
