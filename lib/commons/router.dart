import 'package:flutter/material.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/models/booking.dart';
import 'package:rentalku/models/top_up.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/pages/article_page.dart';
import 'package:rentalku/pages/auth/login_page.dart';
import 'package:rentalku/pages/auth/login_page_driver.dart';
import 'package:rentalku/pages/auth/register_page.dart';
import 'package:rentalku/pages/bookings/add_review_page.dart';
import 'package:rentalku/pages/bookings/detail_booking_page.dart';
import 'package:rentalku/pages/bookings/track_car_page.dart';
import 'package:rentalku/pages/chats/list_chat_page.dart';
import 'package:rentalku/pages/chats/view_chat_page.dart';
import 'package:rentalku/pages/dashboard_page.dart';
import 'package:rentalku/pages/owner/add_driver_page.dart';
import 'package:rentalku/pages/owner/driver_list_page.dart';
import 'package:rentalku/pages/profile/edit_profile_page.dart';
import 'package:rentalku/pages/profile/my_profile_page.dart';
import 'package:rentalku/pages/profile/update_password_page.dart';
import 'package:rentalku/pages/profile/upgrade_owner_car_page.dart';
import 'package:rentalku/pages/undefined_page.dart';
import 'package:rentalku/pages/units/add_driver_complete_page.dart';
import 'package:rentalku/pages/units/add_unit_complete_page.dart';
import 'package:rentalku/pages/units/add_unit_page.dart';
import 'package:rentalku/pages/units/change_location_owner_page.dart';
import 'package:rentalku/pages/units/detail_unit_page.dart';
import 'package:rentalku/pages/units/edit_unit_complete_page.dart';
import 'package:rentalku/pages/units/edit_unit_page.dart';
import 'package:rentalku/pages/units/my_units_page.dart';
import 'package:rentalku/pages/units/order_unit_complete_page.dart';
import 'package:rentalku/pages/units/order_unit_page.dart';
import 'package:rentalku/pages/units/pick_location_page.dart';
import 'package:rentalku/pages/units/review_driver_page.dart';
import 'package:rentalku/pages/units/review_owner_page.dart';
import 'package:rentalku/pages/units/review_product_page.dart';
import 'package:rentalku/pages/units/search_units_page.dart';
import 'package:rentalku/pages/wallets/detail_top_up_page.dart';
import 'package:rentalku/pages/wallets/dompetku_page.dart';
import 'package:rentalku/pages/wallets/top_up_page.dart';
import 'package:rentalku/pages/wallets/topup_complete_page.dart';
import 'package:rentalku/pages/wallets/withdraw_complete_page.dart';
import 'package:rentalku/pages/wallets/withdraw_page.dart';
import 'package:rentalku/pages/welcome_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    /* Home */
    case Routes.home:
      return MaterialPageRoute(builder: (_) => HomePage());

    /* Auth */
    case Routes.login:
      return MaterialPageRoute(builder: (_) => LoginPage());
    case Routes.loginDriver:
      return MaterialPageRoute(builder: (_) => LoginPageDriver());
    case Routes.register:
      return MaterialPageRoute(builder: (_) => RegisterPage());
    case Routes.updatePassword:
      return MaterialPageRoute(builder: (_) => UpdatePasswordPage());

    /* Dashboard */
    case Routes.dashboard:
      return MaterialPageRoute(builder: (_) => DashboardPage());
    case Routes.viewArticle:
      return MaterialPageRoute(builder: (_) => ArticlePage());

    /* Profile */
    case Routes.myProfile:
      return MaterialPageRoute(builder: (_) => MyProfilePage());
    case Routes.editProfile:
      return MaterialPageRoute(builder: (_) => EditProfilePage());

    /* Wallet */
    case Routes.wallet:
      return MaterialPageRoute(builder: (_) => DompetkuPage());
    case Routes.topUp:
      return MaterialPageRoute(builder: (_) => TopUpPage());
    case Routes.detailTopUp:
      return MaterialPageRoute(builder: (_) => DetailTopUpPage(
        topUp: args as TopUp,
      ));
    case Routes.withdraw:
      return MaterialPageRoute(builder: (_) => WithdrawPage());
    case Routes.withdrawComplete:
      return MaterialPageRoute(builder: (_) => WithdrawCompletePage());
    case Routes.topupComplete:
      return MaterialPageRoute(builder: (_) => topupCompletePage());

    /* Units */
    case Routes.searchUnits:
      return MaterialPageRoute(builder: (_) => SearchUnitsPage());
    case Routes.myUnits:
      return MaterialPageRoute(builder: (_) => MyUnitsPage());
    case Routes.detailUnit:
      return MaterialPageRoute(builder: (_) => DetailUnitPage(
        unit: args as Unit,
      ));
    case Routes.addUnit:
      return MaterialPageRoute(builder: (_) => AddUnitPage());
    case Routes.addUnitComplete:
      return MaterialPageRoute(builder: (_) => AddUnitCompletePage());
    case Routes.editUnit:
      return MaterialPageRoute(builder: (_) => EditUnitPage(
        unit: args as Unit
      ));
    case Routes.editUnitComplete:
      return MaterialPageRoute(builder: (_) => EditUnitCompletePage());
    case Routes.reviewProduct:
      return MaterialPageRoute(builder: (_) => ReviewProductPage());
    case Routes.reviewOwner:
      return MaterialPageRoute(builder: (_) => ReviewOwnerPage());
    case Routes.reviewDriver:
      return MaterialPageRoute(builder: (_) => ReviewDriverPage());
    case Routes.orderUnit:
      return MaterialPageRoute(builder: (_) => OrderUnitPage());
    case Routes.pickLocation:
      return MaterialPageRoute(builder: (_) => PickLocationPage());
    case Routes.orderUnitComplete:
      return MaterialPageRoute(builder: (_) => OrderUnitCompletePage());

    /* Bookings */
    case Routes.detailBooking:
      return MaterialPageRoute(builder: (_) => DetailBookingPage(
        booking: args as Booking
      ));
    case Routes.addReviewPage:
      return MaterialPageRoute(builder: (_) => AddReviewPage(
        booking: args as Booking
      ));
    case Routes.trackCar:
      return MaterialPageRoute(builder: (_) => TrackCarPage(
        unit: args as Unit,
      ));

    /* Chats */
    case Routes.chats:
      return MaterialPageRoute(builder: (_) => ListChatPage());
    case Routes.viewChat:
      return MaterialPageRoute(builder: (_) => ViewChatPage());

    /* Owner */
    case Routes.upgradeToOwner:
      return MaterialPageRoute(builder: (_) => UpgradeOwnerCarPage());
    case Routes.driverList:
      return MaterialPageRoute(builder: (_) => DriverListPage());
    case Routes.addDriver:
      return MaterialPageRoute(builder: (_) => AddDriverPage());
    case Routes.addDriverComplete:
      return MaterialPageRoute(builder: (_) => AddDriverCompletePage());
    case Routes.changeLocation:
      return MaterialPageRoute(builder: (_) => ChangeLocationOwnerPage());
  }

  return MaterialPageRoute(
    builder: (_) => UndefinedPage(
      name: settings.name.toString(),
    ),
  );
}
