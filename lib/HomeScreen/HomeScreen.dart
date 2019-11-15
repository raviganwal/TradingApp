import 'dart:async';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tradingapp/ChatProposalScreen/ChatProposalScreen.dart';
import 'package:tradingapp/Component/ColorCode.dart';
import 'package:tradingapp/Component/GlobalStrintText.dart';
import 'package:tradingapp/MyAccountScreen/MyAccountScreen.dart';
import 'package:tradingapp/MyPostScreen/MyPost.dart';
import 'package:tradingapp/NewPostScreen/NewPostScreen.dart';
import 'package:tradingapp/ProposalScreen/ProposalScreen.dart';
//-----------------------------------------------------------------------------------------//
class HomeScreen extends StatefulWidget {
  static String tag = GlobalStringText.tagHomeScreen;

  @override
  _HomeScreenState createState() {
    return new _HomeScreenState();
  }
}
//-----------------------------------------------------------------------------------------//
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  // Create a tab controller
  TextEditingController controller1 = new TextEditingController();
  TabController controller;
  List<Color> _colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  int _currentIndex = 0;
  bool isSmall = false;

//-----------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    // Initialize the Tab Controller
    controller = TabController(length: 5, vsync: this);
  }
//-----------------------------------------------------------------------------------------//
  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }
//-----------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double _width = width * 0.70;
    return new WillPopScope(
      onWillPop: () async {
        Future.value(
            false); //return a `Future` with false value so this route cant be popped or closed.
      },
      child: Scaffold(
 //-----------------------------------------------------------------------------------------//
        // Set the TabBar view as the body of the Scaffold
        body: TabBarView(
          // Add tabs as widgets
          children: <Widget>[ProposalScreen(),ChatProposalScreen(),MyPost(),NewPostScreen(),MyAccountScreen()],
            // set the controller
            controller: controller,
          ),
//-----------------------------------------------------------------------------------------//
        // Set the bottom navigation bar
        bottomNavigationBar: Material(
          // set the color of the bottom navigation bar
          color: ColorCode.AppColorCode,
            // set the tab bar as the child of bottom navigation bar
            child: TabBar(
              labelColor: _colors[_currentIndex],
              labelPadding: new EdgeInsets.only(top:10.0),
              tabs: <Tab>[
//------------------------------------------------------------------------------------//
                new Tab(
                  child: new Column(
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.home,color: ColorCode.WhiteTextColorCode,
                        //size: 15.0,
                        ),
                      SizedBox(height:5.0),
                      new Text(GlobalStringText.Home.toUpperCase().toString(),
                                   style: new TextStyle(fontSize: 9.0,color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold,
                                                        ))
                    ],
                    ),
                  ),
                new Tab(
                  child: new Column(
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.stickyNote,color: ColorCode.WhiteTextColorCode,
                        //size: 15.0,
                        ),
                      SizedBox(height:5.0),
                      new Text(GlobalStringText.proposal.toUpperCase().toString(),
                                   style: new TextStyle(fontSize: 9.0,color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold,
                                                        ))
                    ],
                    ),
                  ),
//-----------------------------------------------------------------------------------------//
                new Tab(
                  child: new Column(
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.envelope,color: ColorCode.WhiteTextColorCode,
                        //size: 15.0,
                        ),
                      SizedBox(height:5.0),
                      new Text(GlobalStringText.MyPost.toUpperCase().toString(),
                                   style: new TextStyle(fontSize: 9.0,color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold,
                                                        ))
                    ],
                    ),
                  ),
//-----------------------------------------------------------------------------------------//
                new Tab(
                  child: new Column(
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.clipboard,color: ColorCode.WhiteTextColorCode,
                        //size: 15.0,
                        ),
                      SizedBox(height:5.0),
                      new Text(GlobalStringText.newpost.toUpperCase().toString(),
                                   style: new TextStyle(fontSize: 9.0,color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold,
                                                        ))
                    ],
                    ),
                  ),
//-----------------------------------------------------------------------------------------//
                new Tab(
                  child: new Column(
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.user,color: ColorCode.WhiteTextColorCode,
                        //size: 15.0,
                        ),
                      SizedBox(height:5.0),
                      new Text(GlobalStringText.Account,
                                   style: new TextStyle(fontSize: 9.0,color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold,
                                                        ))
                    ],
                    ),
                  ),
              ],
              indicatorColor: Colors.white,
              // setup the controller
              controller: controller,
              ),
          ),
        ),
      );
  }
}
//-----------------------------------------------------------------------------------------//