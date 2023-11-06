import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessToken {
  AccessToken({String? msg}) {
    debugPrint("Performing ${msg ?? "Something"} in `AccessToken`");
  }
  Future<bool> storeToken({required String token}) async {
    SharedPreferences obj = await SharedPreferences.getInstance();

    return obj.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences obj = await SharedPreferences.getInstance();

    return obj.getString('token');
  }

  Future<bool> removeToken() async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    return obj.remove('token');
  }
}
