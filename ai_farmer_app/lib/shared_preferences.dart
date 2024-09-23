import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._ctor();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._ctor();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setToken({required String apiKey}) {
    _prefs.setString("token", apiKey);
  }

  static String getToken() {
    return _prefs.getString("token") ?? "";
  }

  static void setSearchResults(String page, String search) {
    if (search.isNotEmpty) {
      var res = _prefs.getStringList(page) ?? [];
      var newRes = [...res, search];
      print(newRes);
      _prefs.setStringList(page, [...res, search]);
    }
  }

  static dynamic getSearchResults(String page) {
    return _prefs.getStringList(page) ?? "";
  }

  static void setIsLoggedIn({required bool status}) {
    _prefs.setBool('isLoggedIn', status);
  }

  static dynamic getIsLoggedIn() {
    return _prefs.getBool("isLoggedIn") ?? false;
  }

  static void setcustomername({required String name}) {
    _prefs.setString("username", name);
  }

  static String getcustomername() {
    return _prefs.getString("username") ?? "";
  }

  static void setuserEmail({required String email}) {
    _prefs.setString("useremail", email);
  }

  static String getuserEmail() {
    return _prefs.getString("useremail") ?? "";
  }

  static void setUserDP({required String dp}) {
    _prefs.setString('profileImage', dp);
  }

  static String getUserDP() {
    return _prefs.getString("profileImage") ?? "";
  }

  static void setPhoneNumber({required String phoneNumber}) {
    _prefs.setString('PhoneNumber', phoneNumber);
  }

  static String getPhoneNumber() {
    return _prefs.getString("PhoneNumber") ?? "";
  }

  static void setfirstname({required String firstname}) {
    _prefs.setString("firstname", firstname);
  }

  static String getfirstname() {
    return _prefs.getString("firstname") ?? "";
  }

  static void setlastname({required String lastname}) {
    _prefs.setString("lastname", lastname);
  }

  static String getlastname() {
    return _prefs.getString("lastname") ?? "";
  }
}
