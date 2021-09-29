import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_repack_assos/constants/config.dart';
import 'package:green_repack_assos/models/user_app_model.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  UserApp? _userApp;
  String? _messageNetwork;

  UserApp? get userApp => _userApp;
  String? get messageNetwork => _messageNetwork;

  Future<bool> signInApp({
    required String username,
    required String password,
  }) async {
    var postbody = {
      "email": '$username',
      "password": "$password",
    };

    try {
      final response = await http.post(
        Uri.parse("${Config.PATH_URL}/api/auth/signin"),
        body: postbody,
      );
      final value = jsonDecode(response.body);
      print("value");
      print(value);
      if (value["accessToken"] == null) {
        print("not exist");
        _messageNetwork = "Utilisateur non trouvé.";
        notifyListeners();
        return false;
      } else {
        _userApp = UserApp.fromJson(value);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("error " + e.toString());
      _messageNetwork = "Une erreur s'est produite. Veuillez réessayer ";
      notifyListeners();
      return false;
    }
  }
}
