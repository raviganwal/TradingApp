import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradingapp/Component/ColorCode.dart';
import 'package:tradingapp/Component/GlobalStrintText.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:tradingapp/LoginScreen/LoginScreen.dart';
//----------------------------------------------------------------------------------------------//
class WalkThrough extends StatefulWidget {
  static String tag = GlobalStringText.tagWalkThrough;
  @override
  WalkThroughState createState() => new WalkThroughState();
}
//----------------------------------------------------------------------------------------------//
class WalkThroughState extends State<WalkThrough> {
  List<Slide> slides = new List();

//----------------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: GlobalStringText.titlesweetimli.toUpperCase(),
        description: GlobalStringText.descriptionsweetimli,
        pathImage: GlobalStringText.Imagesweetimli,
        backgroundColor:ColorCode.AppColorCode,
        ),
      );
    slides.add(
      new Slide(
        title: GlobalStringText.titleSweetTamarind.toUpperCase(),
        description: GlobalStringText.descriptionSweetTamarind,
        pathImage: GlobalStringText.ImageSweetTamarind,
        backgroundColor: ColorCode.AppColorCode,
        ),
      );
    slides.add(
      new Slide(
        title: GlobalStringText.titletamarindimli.toUpperCase(),
        description:
        GlobalStringText.descriptiontamarindimli,
        pathImage: GlobalStringText.Imagetamarindimli,
        backgroundColor: ColorCode.AppColorCode,
        ),
      );
  }
//----------------------------------------------------------------------------------------------//
  void onDonePress() {
   Navigator
        .of(context)
        .push(new MaterialPageRoute(builder: (_) => new LoginScreen()));
  }
//----------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      );
  }
}
//----------------------------------------------------------------------------------------------//