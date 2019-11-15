import 'package:flutter/material.dart';
import 'package:tradingapp/ChatProposalScreen/ChatMessageDetails.dart';
import 'package:tradingapp/ChatProposalScreen/ChatProposalScreen.dart';
import 'package:tradingapp/HomeScreen/HomeScreen.dart';
import 'package:tradingapp/LoginScreen/LoginScreen.dart';
import 'package:tradingapp/MyAccountScreen/MyAccountScreen.dart';
import 'package:tradingapp/MyPostScreen/MyPost.dart';
import 'package:tradingapp/NewPostScreen/NewPostScreen.dart';
import 'package:tradingapp/ProposalScreen/ProposalScreen.dart';
import 'package:tradingapp/ProposalScreen/ProposalScreenDetails.dart';
import 'package:tradingapp/SignupScreen/SignupScreen.dart';
import 'package:tradingapp/SplashScreen/SplashScreen.dart';
import 'package:tradingapp/WalkThrough/WalkThrough.dart';

final routes = {
  '/Splash': (BuildContext context) => new SplashScreen(),
  '/': (BuildContext context) => new SplashScreen(),
  SplashScreen.tag: (context) => SplashScreen(),
  WalkThrough.tag: (context) => WalkThrough(),
  LoginScreen.tag: (context) => LoginScreen(),
  SignupScreen.tag: (context) => SignupScreen(),
  HomeScreen.tag: (context) => HomeScreen(),
  ProposalScreen.tag: (context) => ProposalScreen(),
  ProposalScreenDetails.tag: (context) => ProposalScreenDetails(),
  NewPostScreen.tag: (context) => NewPostScreen(),
  MyAccountScreen.tag: (context) => MyAccountScreen(),
  ChatProposalScreen.tag: (context) => ChatProposalScreen(),
  ChatMessageDetails.tag: (context) => ChatMessageDetails(),
  MyPost.tag: (context) => MyPost()
};
