import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:woo_store/woocommerce/models/login_model.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('login_details') != null ? true : false;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('login_details') != null
        ? LoginResponseModel.fromJson(
            jsonDecode(
              prefs.getString('login_details')!,
            ),
          )
        : null;
  }

  static Future<void> setLoginDetails(
    LoginResponseModel? loginResponse,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    if (loginResponse != null) {
      final res = jsonEncode(loginResponse);
      prefs.setString('login_details', res);
    } else {
      prefs.remove('login_details');
    }
  }

  static Future<void> logout() async {
    await setLoginDetails(null);
  }
}
