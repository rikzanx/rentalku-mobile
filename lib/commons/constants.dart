import 'dart:io';

enum PaymentMethodType {
  BankAccount,
  EWallet,
}

enum UserType {
  User,
  Owner,
  Driver,
}

enum HomeState{
  Initial,
  Loading,
  Loaded,
  Error,
}

final List<String> carTypes = [
  "Sedan",
  "Crossover",
  "Compact MPV",
  "SUV",
  "Mini MPV"
];
final Map<bool, String> carDriverTypes = {
  true: "Dengan Sopir",
  false: "Tanpa Sopir"
};
final String defaultErrorText = "Terjadi kesalahan. Coba lagi nanti";

/* URI */
Uri apiURL = Uri.parse("https://rentalku.pemirahimatepa2021.com/public/api/");
String assetURL = "https://rentalku.pemirahimatepa2021.com/public/";
Map<String, String> acceptJson = {HttpHeaders.acceptHeader: "application/json"};