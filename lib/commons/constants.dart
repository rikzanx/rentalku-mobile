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
Uri apiURL = Uri.parse("https://quiet-stream-85697.herokuapp.com/public/api");
Map<String, String> acceptJson = {HttpHeaders.acceptHeader: "application/json"};
