import 'package:flutter/material.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/models/article.dart';
import 'package:rentalku/pages/article_page.dart';
import 'package:rentalku/pages/auth/login_page.dart';
import 'package:rentalku/pages/auth/register_page.dart';
import 'package:rentalku/pages/bookings/add_review_page.dart';
import 'package:rentalku/pages/bookings/detail_booking_page.dart';
import 'package:rentalku/pages/dashboard_page.dart';
import 'package:rentalku/pages/dompetku/detail_top_up_page.dart';
import 'package:rentalku/pages/dompetku/dompetku_page.dart';
import 'package:rentalku/pages/dompetku/top_up_page.dart';
import 'package:rentalku/pages/profile/my_profile_page.dart';
import 'package:rentalku/pages/profile/rental_mobil_page.dart';
import 'package:rentalku/pages/profile/update_password_page.dart';
import 'package:rentalku/pages/undefined_page.dart';
import 'package:rentalku/pages/welcome_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  final arguments = settings.arguments;
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (_) => HomePage());
    case Routes.login:
      return MaterialPageRoute(builder: (_) => LoginPage());
    case Routes.register:
      return MaterialPageRoute(builder: (_) => RegisterPage());
    case Routes.dashboard:
      return MaterialPageRoute(builder: (_) => DashboardPage());
    case Routes.updatePassword:
      return MaterialPageRoute(builder: (_) => UpdatePasswordPage());
    case Routes.dompetku:
      return MaterialPageRoute(builder: (_) => DompetkuPage());
    case Routes.topUp:
      return MaterialPageRoute(builder: (_) => TopUpPage());
    case Routes.detailTopUp:
      return MaterialPageRoute(builder: (_) => DetailTopUpPage());
    case Routes.rentalMobil:
      return MaterialPageRoute(builder: (_) => RentalMobilPage());
    case Routes.detailBooking:
      return MaterialPageRoute(builder: (_) => DetailBookingPage());
    case Routes.addReviewPage:
      return MaterialPageRoute(builder: (_) => AddReviewPage());
    case Routes.myProfile:
      return MaterialPageRoute(builder: (_) => MyProfilePage());
    case Routes.article:
      if (arguments is Article)
        return MaterialPageRoute(
          builder: (_) => ArticlePage(article: arguments),
        );
  }

  return MaterialPageRoute(
    builder: (_) => UndefinedPage(
      name: settings.name.toString(),
    ),
  );
}
