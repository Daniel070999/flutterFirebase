import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RegisterProvider extends ChangeNotifier{
  RegisterProvider(){
    print("Iniciando register provider...");
  }
  Future<bool> registrarUsuario(Map<String, String> formData) async{
    var url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBJA0QhG0TlpoxDexNtMJe8Te10Osd9peA'
    );
    var response = await http.post(url, body: jsonEncode(formData));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
