import 'package:flutter/material.dart';
import 'package:tradingapp/routes.dart';
import 'package:flutter/services.dart';
import 'package:tradingapp/Component/ColorCode.dart';
//--------------------------------------------------------------------------------------------------------------//
void main() => runApp(new MyApp());
Map<int, Color> color =
{
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(136,14,79, .2),
  200:Color.fromRGBO(136,14,79, .3),
  300:Color.fromRGBO(136,14,79, .4),
  400:Color.fromRGBO(136,14,79, .5),
  500:Color.fromRGBO(136,14,79, .6),
  600:Color.fromRGBO(136,14,79, .7),
  700:Color.fromRGBO(136,14,79, .8),
  800:Color.fromRGBO(136,14,79, .9),
  900:Color.fromRGBO(136,14,79, 1),
};
//--------------------------------------------------------------------------------------------------------------//
class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  void initState() {
  }
//--------------------------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorCode.AppColorCode
        ));
    MaterialColor colorCustom = MaterialColor(0xFFCEA910, color);
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: colorCustom,
        ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      );
  }
}
//--------------------------------------------------------------------------------------------------------------//
