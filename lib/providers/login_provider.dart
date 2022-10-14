import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practiacflutter/models/user.dart';

class LoginProvider extends ChangeNotifier {
  String endPoint = 'https://identitytoolkit.googleapis.com/v1/';
  LoginProvider() {
    print("Iniciando login provider...");
  }

  Future<User?> loginUsuario(Map<String, String> formData) async {
    var url = Uri.parse(endPoint +
        'accounts:signInWithPassword?key=AIzaSyBJA0QhG0TlpoxDexNtMJe8Te10Osd9peA');
    var response = await http.post(url, body: jsonEncode(formData));
    if (response.statusCode == 200) {
      var usuario = User.fromJson(jsonDecode(response.body));
      var urlDb = Uri.parse(
          'https://practicaflutter-6e5e0-default-rtdb.firebaseio.com/users/' +
              usuario.localId! +
              '.json');

      var responseDb = await http.get(urlDb);
      if (responseDb.statusCode == 200) {
        usuario.setUserData(jsonDecode(responseDb.body));
        return usuario;
      }
    }
    return null;
  }
}
