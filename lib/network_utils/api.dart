import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'https://quiet-stream-85697.herokuapp.com/public/api';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var tokenCheck, token = null;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    tokenCheck = localStorage.getString('token');
    if (tokenCheck != null) {
      token = jsonDecode(tokenCheck)['token'];
    }
  }

  authData(data, apiUrl) async {
    var fullUrl = Uri.parse(_url + apiUrl);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = Uri.parse(_url + apiUrl);
    await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
