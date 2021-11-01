

enum PaymentMethodType {
  BankAccount,
  EWallet,
}

enum UserType {
  User,
  Owner,
  Driver,
}

final List<String> carTypes = ["Sedan", "Crossover", "Compact MPV", "SUV", "Mini MPV"];
final Map<bool, String> carDriverTypes = {true: "Dengan Sopir", false: "Tanpa Sopir"};