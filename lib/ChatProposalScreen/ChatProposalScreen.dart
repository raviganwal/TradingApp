import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:tradingapp/ChatProposalScreen/ChatMessageDetails.dart';
import 'package:tradingapp/Component/GlobalStrintText.dart';
import 'package:tradingapp/Component/ColorCode.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tradingapp/HomeScreen/HomeScreen.dart';
import 'package:tradingapp/LoginScreen/responsive_ui.dart';
import 'package:tradingapp/LoginScreen/FadeAnimation.dart';
import 'package:tradingapp/Model/ProposalModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:tradingapp/ProposalScreen/ProposalScreenDetails.dart';
import 'package:tradingapp/Preferences/Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradingapp/SplashScreen/SplashScreen.dart';
//-----------------------------------------------------------------------------------------//
class ChatProposalScreen extends StatefulWidget {
  static String tag = GlobalStringText.tagChatProposalScreen;

  @override
  _ChatProposalScreenState createState() {
    return new _ChatProposalScreenState();
  }
}
//-----------------------------------------------------------------------------------------//
class _ChatProposalScreenState extends State<ChatProposalScreen>{
  var loading = true;
  String status = '';
  String errMessage = GlobalStringText.errMessage;
  var data;
  List<JSONDATA> _listProposal = [];
  String ReciveAdv_ID = '';
  String ReciveTitle = '';
  var ReciveUserID="";
  var ReciveUserEmail="";
  var ReciveUserFullName="";
//----------------------------------------------------------------------------------------------//
  @override
  void initState() {
    this._checkInternetConnectivity(context);
    this.fetchProposal();
  }
//-----------------------------------------------------------------------------------------//
  String Proposalurl ='http://192.168.0.200/anuj/ATMA/HomePageAdv.php';
  fetchProposal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ReciveUserID = prefs.getString(Preferences.KEY_UserID).toString();
    ReciveUserEmail = prefs.getString(Preferences.KEY_Email).toString();
    ReciveUserFullName = prefs.getString(Preferences.KEY_FullName).toString();
    http.post(Proposalurl, body: {
      "Token": GlobalStringText.Token,
    }).then((resultProposal) {
      setStatus(resultProposal.statusCode == 200 ? resultProposal.body : errMessage);
      data = json.decode(resultProposal.body);
      if(!data['Status']) {
        _StatusFalseAlert(context);
        loading = false;
        return;
      }
      else{
        final ExtractData = jsonDecode(resultProposal.body);
        data = ExtractData["JSONDATA"];
        //print(data.toString());
        setState(() {
          for (Map i in data) {
            _listProposal.add(JSONDATA.fromJson(i));
            loading = false;
          }
        });
      }
    }).catchError((error) {
      setStatus(error);
    });
  }
//---------------------------------------------------------------------------------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
  //-----------------------------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return new WillPopScope(
      onWillPop: () async {
        Future.value(
            false); //return a `Future` with false value so this route cant be popped or closed.
      },
      child: new Scaffold(
        drawer: new Drawer(
            child: new ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  new Container(
                    color: ColorCode.AppColorCode,
                    child: new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new Row(children: <Widget>[
                        new GestureDetector(
                          onTap: () {
                            //_showOnTapMessage(context, "Clicked!");
                            //Navigator.pop(context, true);
                          },
                          child: new Container(
                            child: CircleAvatar(
                              backgroundImage: ExactAssetImage(GlobalStringText.ImagetSplashScreenLogo),
                              minRadius: 90,
                              maxRadius: 100,
                              ),
                            margin: const EdgeInsets.all(5.0),
                            width: 80.0,
                            height: 80.0,
                            ),
                          ),
                        new Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("Mr. "+
                                             ReciveUserFullName,
                                           style: TextStyle(
                                               fontSize: 12.0,
                                               color: Colors.white,
                                               letterSpacing: 1.4,
                                               backgroundColor: Colors.transparent,
                                               fontWeight: FontWeight.bold),
                                         ),
                                new Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: new Text(
                                    ReciveUserEmail,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.white,
                                        letterSpacing: 1.4,
                                        backgroundColor: Colors.transparent,
                                        fontWeight: FontWeight.bold),
                                    ),
                                  ),
                              ]),
                          ),
                      ]),
                      ),
                    ),
//-----------------------------------------------------------------------------------------//
                  new Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: new Row(children: <Widget>[
                      new Container(
                        child: new Icon(
                          FontAwesomeIcons.home,color: ColorCode.AppColorCode,
                          //size: 15.0,
                          ),
                        margin: const EdgeInsets.all(10.0),

                        ),
                      new Container(
                        child: new GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(HomeScreen.tag);
                          },
                          child: new Text(GlobalStringText.Home.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: ColorCode.AppColorCode,
                                                  letterSpacing: 1.4,
                                                  backgroundColor: Colors.transparent,
                                                  fontWeight: FontWeight.bold)),
                          ),
                        margin: const EdgeInsets.only(left: 10.0,top: 5.0,),
                        ),
                    ]),
                    ),
//-----------------------------------------------------------------------------------------//
                  new Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: new Row(children: <Widget>[
                      new Container(
                        child: new Icon(
                          FontAwesomeIcons.stickyNote,color: ColorCode.AppColorCode,
                          //size: 15.0,
                          ),
                        margin: const EdgeInsets.all(10.0),

                        ),
                      new Container(
                        child: new GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(HomeScreen.tag);
                          },
                          child: new Text(GlobalStringText.proposal.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: ColorCode.AppColorCode,
                                                  letterSpacing: 1.4,
                                                  backgroundColor: Colors.transparent,
                                                  fontWeight: FontWeight.bold)),
                          ),
                        margin: const EdgeInsets.only(left: 10.0,top: 5.0,),
                        ),
                    ]),
                    ),
//-----------------------------------------------------------------------------------------//
                  new Divider(),
                  new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Row(children: <Widget>[
                      new Container(
                        child: new Icon(
                          FontAwesomeIcons.envelope,color: ColorCode.AppColorCode,
                          //size: 15.0,
                          ),
                        margin: const EdgeInsets.all(10.0),

                        ),
                      new Container(
                        child: new GestureDetector(
                          onTap: () {
                            //Navigator.of(context).pushNamed(MyPost.tag);
                          },
                          child: new Text(GlobalStringText.MyPost.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: ColorCode.AppColorCode,
                                                  letterSpacing: 1.4,
                                                  backgroundColor: Colors.transparent,
                                                  fontWeight: FontWeight.bold)),
                          ),
                        margin: const EdgeInsets.only(left: 10.0,top: 5.0,),
                        ),
                    ]),
                    ),
//-----------------------------------------------------------------------------------------//
                  new Divider(),
                  new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Row(children: <Widget>[
                      new Container(
                        child: new Icon(
                          FontAwesomeIcons.clipboard,color: ColorCode.AppColorCode,
                          //size: 15.0,
                          ),
                        margin: const EdgeInsets.all(10.0),

                        ),
                      new Container(
                        child: new GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushNamed(NewPost.tag);
                          },
                          child: new Text(GlobalStringText.newpost.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: ColorCode.AppColorCode,
                                                  letterSpacing: 1.4,
                                                  backgroundColor: Colors.transparent,
                                                  fontWeight: FontWeight.bold)),
                          ),
                        margin: const EdgeInsets.only(left: 10.0,top: 5.0),
                        ),
                    ]),
                    ),
//-----------------------------------------------------------------------------------------//
                  new Divider(),
                  new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Row(children: <Widget>[
                      new Container(
                        child: new Icon(
                          FontAwesomeIcons.user,color: ColorCode.AppColorCode,
                          //size: 15.0,
                          ),
                        margin: const EdgeInsets.all(10.0),

                        ),
                      new Container(
                        child: new GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushNamed(Account.tag);
                          },
                          child: new Text(GlobalStringText.Account.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: ColorCode.AppColorCode,
                                                  letterSpacing: 1.4,
                                                  backgroundColor: Colors.transparent,
                                                  fontWeight: FontWeight.bold)),
                          ),
                        margin: const EdgeInsets.only(left: 10.0,top:5.0,),
                        ),
                    ]),
                    ),
//-----------------------------------------------------------------------------------------//
                  new Divider(),
                  new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Row(children: <Widget>[
                      new Container(
                        child: new Icon(
                          FontAwesomeIcons.signOutAlt,color: ColorCode.AppColorCode,
                          //size: 15.0,
                          ),
                        margin: const EdgeInsets.all(10.0),

                        ),
                      new Container(
                        child: new GestureDetector(
                          onTap: () {
                            TapMessage(context, "Logout!");
                          },
                          child: new Text(GlobalStringText.Logout.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: ColorCode.AppColorCode,
                                                  letterSpacing: 1.4,
                                                  backgroundColor: Colors.transparent,
                                                  fontWeight: FontWeight.bold)),
                          ),
                        margin: const EdgeInsets.only(left: 10.0,top: 5.0,),
                        ),
                    ]),
                    ),
                  new Divider(),
                ]
                )
            ),
//-----------------------------------------------------------------------------------------//
        appBar: new AppBar(
          title: Text(GlobalStringText.proposal.toUpperCase(),style: TextStyle(
              fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.w500),),
          iconTheme: new IconThemeData(color: Colors.white),
          centerTitle: true,
          //titleSpacing: -15.0,
          actions: <Widget>[
            new IconButton(
              icon: Icon(FontAwesomeIcons.bell,color: Colors.white),
              //tooltip: 'Increase volume by 10',
              onPressed: () {
                /* setState(() {
                  _volume += 10;
                })*/;
              },
              ),
          ],
          ),
        body: new FadeAnimation(2, Container(
          child: new Stack(
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(top: 0.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    loading
                        ? Center(
                      child: CircularProgressIndicator(backgroundColor: ColorCode.AppColorCode),
                      ): Expanded(child:
                                  ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: _listProposal.length,
                                      itemBuilder: (context, i) {
                                        final ReciveProposalObject = _listProposal[i];
                                        return new Container(
                                          child: new GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                ReciveAdv_ID =ReciveProposalObject.advID.toString();
                                                ReciveTitle =ReciveProposalObject.title.toString();//if you want to assign the index somewhere to check//if you want to assign the index somewhere to check//if you want to assign the index somewhere to check//if you want to assign the index somewhere to check
                                                print("OnClickItemReciveAdv_ID"+ReciveAdv_ID.toString());
                                                print("OnClickItemReciveTitle"+ReciveTitle.toString());
                                              });
                                              var route = new MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                new ChatMessageDetails(
                                                    value1: " ${ReciveAdv_ID.toString()}",
                                                    value2: " ${ReciveTitle.toString()}"
                                                    ),
                                                );
                                              Navigator.of(context).push(route);
                                            },
                                            child: new Card(
                                              margin: new EdgeInsets.only(left: 5.0, right: 5.0, top: 8.0, bottom: 5.0),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                              elevation: 4.0,
                                              child: new Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  new ListTile(
                                                    leading: new AspectRatio(
                                                      aspectRatio: 2,
                                                      child: Image.network("http://192.168.0.200/anuj/ATMA/images/noimage.jpg",
                                                                             fit: BoxFit.contain,
                                                                           ),
                                                      ),
                                                    title: new Text(ReciveProposalObject.title,
                                                                        style: new TextStyle(
                                                                            color: new Color.fromARGB(255, 117, 117, 117),
                                                                            fontSize: 15.0,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Roboto')
                                                                    ),
                                                    subtitle: new Text(ReciveProposalObject.description),
                                                    trailing: Icon(Icons.keyboard_arrow_right,color: ColorCode.AppColorCode,),
                                                    ),

                                                ],
                                                ),
                                              ),
                                            ),

                                          );
                                      })
                                  )
                  ],
                  ),
                ),
            ],
            ),
          ),
                                ),
        ),
      );
  }
//------------------------------------------AlertDilog------------------------------------//
  Future<void> _StatusFalseAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(GlobalStringText.SomethingWentWrong, textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 15.0,
                                                 color: ColorCode.AppColorCode,
                                                 fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(GlobalStringText.DataNotAvilable.toString(),
                       textAlign: TextAlign.center,
                       style: new TextStyle(fontSize: 12.0,
                                                color: ColorCode.AppColorCode,
                                                fontWeight: FontWeight.bold),),
              ],
              ),
            ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(GlobalStringText.TryAgain, style: new TextStyle(fontSize: 15.0,
                                                                              color: ColorCode.AppColorCode,
                                                                              fontWeight: FontWeight
                                                                                  .bold),),
              ),
          ],
          );
      },
      );
  }
  //----------------------------------------------------------------------------------------------------------//
  void _checkInternetConnectivity(BuildContext context) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _InterNetshowDialog(
          GlobalStringText.Nointernet,
          GlobalStringText.notconnectednetwork
          );
    }
  }
//--------------------------------------------------------------------------------------------------------//
  Future<void> _InterNetshowDialog(title, text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(GlobalStringText.InternetWarning, textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 15.0,
                                                 color: ColorCode.AppColorCode,
                                                 fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(title.toString(),
                       textAlign: TextAlign.center,
                       style: new TextStyle(fontSize: 12.0,
                                                color: ColorCode.AppColorCode,
                                                fontWeight: FontWeight.bold),),
              ],
              ),
            ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                //("hello123"+id.toString());
                Navigator.of(context).pop();
              },
              child: Text(GlobalStringText.ok, style: new TextStyle(fontSize: 15.0,
                                                                        color: ColorCode.AppColorCode,
                                                                        fontWeight: FontWeight
                                                                            .bold),),
              ),
          ],
          );
      },
      );
  }
//---------------------------------------------------------------------------------------------------//
  void TapMessage(BuildContext context, String message) {
    var alert = new AlertDialog(
      title: new Text('Want to logout?'),
      content: new Text(message),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              removeData(context);
            },
            child: new Text('OK'))
      ],
      );
    showDialog(context: context, child: alert);
  }
//---------------------------------------------------------------------------------------------------//
  removeData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(Preferences.KEY_UserStatus);
    Navigator.of(context).pushNamed(SplashScreen.tag);
  }
}
//-----------------------------------------------------------------------------------------//