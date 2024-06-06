import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferencesHelper {

  static String userIdKey = "USERKY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userImageKey = "USERIMAGEKEY";

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    return pres.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    return pres.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    return pres.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserImage(String getUserImage) async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    return pres.setString(userImageKey, getUserImage);
  }

  Future<String?> getUserId() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    return pres.getString(userIdKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    return pres.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    return pres.getString(userEmailKey);
  }

  Future<String?> getUserImage() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    return pres.getString(userImageKey);
  }

}