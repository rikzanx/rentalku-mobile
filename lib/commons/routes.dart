class Routes {
  Routes._();

  /* Home */
  static const String home = '/';

  /* Auth */
  static const String login = '/login';
  static const String loginDriver = '/login/driver';
  static const String register = '/register';
  static const String updatePassword = '/update-password';

  /* Dashboard */
  static const String dashboard = '/dashboard';
  static const String viewArticle = '/article/view';

  /* Profile */
  static const String myProfile = '/profile';
  static const String editProfile = '/profile/edit';

  /* Wallet */
  static const String wallet = '/wallet';
  static const String topUp = '/wallet/top-up';
  static const String detailTopUp = '/wallet/top-up/detail';
  static const String topupComplete = '/wallet/top-up/complete';
  static const String withdraw = '/wallet/withdraw';
  static const String withdrawComplete = '/wallet/withdraw/complete';

  /* Units */
  static const String searchUnits = '/units/search';
  static const String myUnits = '/units/my';
  static const String detailUnit = '/units/detail';
  static const String addUnit = '/units/detail/add';
  static const String addUnitComplete = '/units/detail/add/complete';
  static const String editUnit = '/units/detail/edit';
  static const String editUnitComplete = '/units/detail/edit/complete';
  static const String reviewProduct = '/units/detail/review-product';
  static const String reviewOwner = '/units/detail/review-owner';
  static const String reviewDriver = '/units/detail/review-driver';
  static const String orderUnit = '/units/detail/order';
  static const String pickLocation = '/units/detail/order/location';
  static const String orderUnitComplete = '/units/detail/order/complete';

  /* Bookings */
  static const String detailBooking = '/bookings/detail';
  static const String addReviewPage = '/bookings/add-reviews';
  static const String trackCar = '/bookings/detail/track';

  /* Chats */
  static const String chats = '/chats';
  static const String viewChat = '/chats/view';

  /* Owner */
  static const String upgradeToOwner = '/upgrade-to-owner';
  static const String driverList = '/owner/drivers';
  static const String addDriver = '/owner/drivers/add';
  static const String addDriverComplete = '/owner/drivers/add/complete';
  static const String changeLocation = '/owner/change/location';
}
