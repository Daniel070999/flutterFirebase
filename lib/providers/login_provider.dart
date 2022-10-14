import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier{
  LoginProvider(){
    print("Iniciando login provider...");
  }

  Future<bool> loginUsuario(Map<String, String> formData) async{
    var url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBJA0QhG0TlpoxDexNtMJe8Te10Osd9peA'
    );
    var response = await http.post(url, body: jsonEncode(formData));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}