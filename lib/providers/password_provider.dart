import 'package:flutter/cupertino.dart';
import 'package:rentalku/commons/constants.dart';

class PasswordProvider extends ChangeNotifier {

  HomeState _homeState = HomeState.Initial;
  HomeState get homeState => _homeState;

  bool _obsecureText = true;
  bool get obsecureText => _obsecureText;
  set obsecureText(bool obsecureText){
    _obsecureText = obsecureText;
    notifyListeners();
  }

  bool _obsecureText2 = true;
  bool get obsecureText2 => _obsecureText2;
  set obsecureText2(bool obsecureText2){
    _obsecureText2 = obsecureText2;
    notifyListeners();
  }
}