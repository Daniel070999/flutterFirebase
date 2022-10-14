import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practiacflutter/models/user.dart';

class RegisterProvider extends ChangeNotifier {
  String endPoint = 'https://identitytoolkit.googleapis.com/v1/';
  RegisterProvider() {
    print("Iniciando register provider...");
  }
  Future<bool> registrarUsuario(Map<String, String> formData) async {
    var url = Uri.parse(endPoint +
        'accounts:signUp?key=AIzaSyBJA0QhG0TlpoxDexNtMJe8Te10Osd9peA');
    var response = await http.post(url, body: jsonEncode(formData));
    if (response.statusCode == 200) {
      var usuario = User.fromJson(jsonDecode(response.body));
      print(usuario.localId);

      var urlDb = Uri.parse(
          'https://practicaflutter-6e5e0-default-rtdb.firebaseio.com/users/' +
              usuario.localId! +
              '.json');

      var responseDb = await http.put(urlDb,
          body: jsonEncode(
              {'name': formData['name'], 'lastname': formData['lastname']}));
              if (response.statusCode == 200) {
                return true;
              }else{
                return false;
              }
    }
    return false;
  }
}
