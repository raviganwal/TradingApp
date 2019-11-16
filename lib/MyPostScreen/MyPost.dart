import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:tradingapp/Component/GlobalStrintText.dart';
import 'package:tradingapp/Component/ColorCode.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tradingapp/HomeScreen/HomeScreen.dart';
import 'package:tradingapp/LoginScreen/responsive_ui.dart';
import 'package:tradingapp/LoginScreen/FadeAnimation.dart';
import 'package:tradingapp/Model/MyPostModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:tradingapp/MyPostScreen/MyPostDetails.dart';
import 'package:tradingapp/ProposalScreen/ProposalScreenDetails.dart';
import 'package:tradingapp/Preferences/Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradingapp/SplashScreen/SplashScreen.dart';
//-----------------------------------------------------------------------------------------//
class MyPost extends StatefulWidget {
  static String tag = GlobalStringText.tagMyPost;

  @override
  _MyPostState createState() {
    return new _MyPostState();
  }
}
//-----------------------------------------------------------------------------------------//
class _MyPostState extends State<MyPost>{
  var loading = true;
  String status = '';
  String errMessage = GlobalStringText.errMessage;
  var dataMyPostData;
  List<JSONDATA> _listMyPost = [];
  String ReciveAdv_ID = '';
  String ReciveTitle = '';
  var ReciveUserID="";
  var ReciveUserEmail="";
  var ReciveUserFullName="";
  var MyPostDataGetStatus ="";
//----------------------------------------------------------------------------------------------//
  @override
  void initState() {
    this._checkInternetConnectivity(context);
    this.fetchMyPostData();
  }
//-----------------------------------------------------------------------------------------//
  String MyPostDataurl ='http://192.168.0.200/anuj/ATMA/MyADV.php';
  fetchMyPostData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ReciveUserID = prefs.getString(Preferences.KEY_UserID).toString();
    ReciveUserEmail = prefs.getString(Preferences.KEY_Email).toString();
    ReciveUserFullName = prefs.getString(Preferences.KEY_FullName).toString();
    http.post(MyPostDataurl, body: {
      "Token": GlobalStringText.Token,
      "User_ID": ReciveUserID.toString(),
    }).then((resultMyPostData) {
      print("Url"+MyPostDataurl);
      setStatus(resultMyPostData.statusCode == 200 ? resultMyPostData.body : errMessage);
      print("jsonresp ${resultMyPostData.body}");
      dataMyPostData = json.decode(resultMyPostData.body);
      MyPostDataGetStatus = dataMyPostData["Status"].toString();
//--------------------------------------------------------------------------------------//
      if(MyPostDataGetStatus == "true"){
        print("true");
        final ExtractData = jsonDecode(resultMyPostData.body);
        dataMyPostData = ExtractData["JSONDATA"];
        setState(() {
          for (Map i in dataMyPostData) {
            _listMyPost.add(JSONDATA.fromJson(i));
            loading = false;
          }
        });
      }else if(MyPostDataGetStatus == "false"){
        print("false");
        loading = false;
        _StatusFalseAlert(context);
      }
//--------------------------------------------------------------------------------------//
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

//----------------------------------------------------------------------------------------------//
  final ProposalHeader = new Padding(
    padding: const EdgeInsets.all(10.0),
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                GlobalStringText.proposal.toUpperCase(),
                style: TextStyle(
                    color:ColorCode.AppColorCode,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                ),
              new GestureDetector(
                /* onTap: () {
                  var route = new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new SeeAllScreen()
                      );
                  Navigator.of(context).push(route);
                },*/
                child: new Text(
                    GlobalStringText.SeeAll.toUpperCase(),
                    style: TextStyle(
                        color:ColorCode.AppColorCode,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                ),
            ],
            ),
          ),
      ],
      ),
    );
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
          title: Text(GlobalStringText.MyPost.toUpperCase(),style: TextStyle(
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
                    new Container(
                      //color: Colors.grey,
                      height: 40.0, width: _width, child: ProposalHeader),
                    loading
                        ? Center(
                      child: CircularProgressIndicator(backgroundColor: ColorCode.AppColorCode),
                      ): Expanded(child:
                                  GridView.builder(
                                      padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(top: 0),
                                      itemCount: _listMyPost.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,),
                                      itemBuilder: (context, i) {
                                        final ReciveProposalObject = _listMyPost[i];
                                        return new Container(
                                          child: new GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                ReciveAdv_ID =ReciveProposalObject.advID.toString(); //if you want to assign the index somewhere to check//if you want to assign the index somewhere to check
                                                ReciveTitle =ReciveProposalObject.title.toString(); //if you want to assign the index somewhere to check//if you want to assign the index somewhere to check
                                                print("OnClickItemReciveAdv_ID"+ReciveAdv_ID.toString());
                                                print("OnClickItemReciveTitle"+ReciveTitle.toString());
                                              });
                                              var route = new MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                new MyPostDetails(
                                                    value1: " ${ReciveAdv_ID.toString()}",
                                                    value2: " ${ReciveTitle.toString()}"
                                                    ),
                                                );
                                              Navigator.of(context).push(route);
                                            },
                                            child: new Card(
                                              color: ColorCode.ImageBackgroundColorCode,
                                              margin: new EdgeInsets.only(left: 5.0, right: 8.0, top: 5.0, bottom: 8.0),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                              elevation: 4.0,
                                              child: Padding(
                                                padding:
                                                EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Image.network(
                                                          "http://192.168.0.200/anuj/ATMA/images/noimage.jpg",
                                                          width: 150,
                                                          height: 150,
                                                          ),
                                                        ),
                                                      Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: Text(
                                                          ReciveProposalObject.title.toUpperCase().toString(),style: TextStyle(color: ColorCode.AppColorCode),
                                                          maxLines: 1,
                                                          softWrap: true,
                                                          textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                    ],
                                                    ),
                                                  ),
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
  //------------------------------------------AlertDilogTapMessage------------------------------------//
  Future<void> TapMessage(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message, textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 15.0,
                                                 color: ColorCode.AppColorCode,
                                                 fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(GlobalStringText.LogOut.toString(),
                       textAlign: TextAlign.center,
                       style: new TextStyle(fontSize: 12.0,
                                                color: ColorCode.BlackTextColorCode,
                                                fontWeight: FontWeight.bold),),
              ],
              ),
            ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(GlobalStringText.Cancle, style: new TextStyle(fontSize: 15.0,
                                                                            color: ColorCode.GreenTextColorCode,
                                                                            fontWeight: FontWeight
                                                                                .bold),),
              ),
            FlatButton(
              onPressed: () {
                removeData(context);
              },
              child: Text(GlobalStringText.ok, style: new TextStyle(fontSize: 15.0,
                                                                        color: ColorCode.RedTextColorCode,
                                                                        fontWeight: FontWeight
                                                                            .bold),),
              ),

          ],
          );
      },
      );
  }
//---------------------------------------------------------------------------------------------------//
  removeData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(Preferences.KEY_FullName);
    prefs.remove(Preferences.KEY_UserID);
    prefs.remove(Preferences.KEY_Email);
    prefs.remove(Preferences.KEY_UserStatus);
    prefs.remove(Preferences.KEY_FirstNAME);
    prefs.remove(Preferences.KEY_LastNAME);
    Navigator.of(context).pushNamed(SplashScreen.tag);
  }
}
//-----------------------------------------------------------------------------------------//