import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradingapp/Component/ColorCode.dart';
import 'package:tradingapp/Component/GlobalStrintText.dart';
import 'package:tradingapp/HomeScreen/HomeScreen.dart';
import 'package:tradingapp/WalkThrough/WalkThrough.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradingapp/Preferences/Preferences.dart';
//----------------------------------------------------------------------------------------------//
class SplashScreen extends StatefulWidget {
  static String tag = GlobalStringText.tagSplashScreen;
  @override
  SplashScreenState createState() => new SplashScreenState();
}
//----------------------------------------------------------------------------------------------//
class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
//----------------------------------------------------------------------------------------------//
  void handleTimeout() async {
    //print("hello");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("KEY_UserID"+prefs.getString(Preferences.KEY_UserID.toString()));
    if (prefs.getString(Preferences.KEY_UserStatus) != null) {
      if (prefs.getString(Preferences.KEY_UserStatus) == 'Active') {
        // print("Preferences.KEY_UserID"+Preferences.KEY_UserStatus);
        Navigator.of(context).pushNamed(HomeScreen.tag);
      }
    } else {
      Navigator
          .of(context)
          .push(new MaterialPageRoute(builder: (_) => new WalkThrough()));
    }
  }
//----------------------------------------------------------------------------------------------//
  startTimeout() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, handleTimeout);
  }
//----------------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    startTimeout();
  }
//----------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorCode.AppColorCode,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: new Text(
                  GlobalStringText.AppDeveloperCompanyName,style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,color:ColorCode.BlackTextColorCode),
                  ),
                )
            ],
            ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                GlobalStringText.ImagetSplashScreenLogo,
                fit: BoxFit.contain,
                ),
            ],
            ),
        ],
        ),
      );
  }
}
//----------------------------------------------------------------------------------------------//