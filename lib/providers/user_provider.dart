import 'package:flutter/material.dart';
import 'package:practiacflutter/models/user.dart';

class UserProvider extends ChangeNotifier {
  User user = User();

  setUser(User _user){
    user = _user;
    notifyListeners();
  }
}