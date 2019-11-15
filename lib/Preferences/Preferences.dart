import 'package:tradingapp/Model/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';

class Preferences {
  static var KEY_UserID = "USER_ID";
  static var KEY_UserStatus = "Active";
  static var KEY_FirstNAME = "First Name";
  static var KEY_LastNAME = "Last Name";
  static var KEY_Email = "Email";
  static var KEY_FullName = "FullName";


  storeDataAtLogin(LoginModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_UserID, data.jSONDATA.uSERID);
    prefs.setString(KEY_UserStatus, data.jSONDATA.status);
    prefs.setString(KEY_FirstNAME, data.jSONDATA.firstName);
    prefs.setString(KEY_LastNAME, data.jSONDATA.lastName);
    prefs.setString(KEY_Email, data.jSONDATA.email);
    prefs.setString(KEY_FullName, data.jSONDATA.firstName+""+data.jSONDATA.lastName);
  }
}
