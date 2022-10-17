import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:practiacflutter/models/user.dart';

class UserProvider extends ChangeNotifier {
  String endPoint = 'https://identitytoolkit.googleapis.com/v1/';

  User user = User();

  setUser(User _user) {
    user = _user;
    notifyListeners();
  }

  setUserLocation(double latitud, double longitud){
    user.setLocation(latitud, longitud);
    notifyListeners();
  }

  Future<bool> updateUsuario(Map<String, String> formData) async {
    var urlDb = Uri.parse(
        'https://practicaflutter-6e5e0-default-rtdb.firebaseio.com/users/' +
            formData['localID']! +
            '.json');

    var responseDb = await http.put(urlDb, body: jsonEncode(formData));
    if (responseDb.statusCode == 200) {
      user.setUserData(jsonDecode(responseDb.body));
      notifyListeners();
      return true;
    } else {
      return false;
    }
    return false;
  }
}
