import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradingapp/Component/ColorCode.dart';
import 'package:tradingapp/Component/GlobalStrintText.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:tradingapp/HomeScreen/HomeScreen.dart';
import 'package:tradingapp/LoginScreen/FadeAnimation.dart';
import 'package:tradingapp/LoginScreen/LoginScreen.dart';
import 'package:tradingapp/LoginScreen/responsive_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tradingapp/Model/ProfileViewModel.dart';
import 'package:tradingapp/Preferences/Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:tradingapp/SplashScreen/SplashScreen.dart';
//----------------------------------------------------------------------------------------------//
class MyAccountScreen extends StatefulWidget {
  static String tag = GlobalStringText.tagMyAccountScreen;
  @override
  MyAccountScreenState createState() => new MyAccountScreenState();
}
//----------------------------------------------------------------------------------------------//
class MyAccountScreenState extends State<MyAccountScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  ScrollController _scrollController = new ScrollController();

  TextEditingController ProfileFirstNameController = new TextEditingController();
  TextEditingController ProfileLastNameController = new TextEditingController();
  TextEditingController ProfileMobileNumberController = new TextEditingController();
  /*TextEditingController ProfileEmailController = new TextEditingController();*/
  TextEditingController ProfileStatusController = new TextEditingController();

  final FocusNode myFocusNodeFirstName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();
  final FocusNode myFocusNodeMobileNumber = FocusNode();
  /*final FocusNode myFocusNodeEmail = FocusNode();*/
  final FocusNode myFocusNodeStatus = FocusNode();
  var loading = true;
  String status = '';
  String errMessage = GlobalStringText.errMessage;
  var data;
  var dataProfileUpdate;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var ReciveUserID="";
  var ReciveUserEmail="";
  var ReciveUserFullName="";
  List<JSONDATA> _listProfileView = [];

  var ReciveDataUserFirstName = "";
  var ReciveDataUserLastName = "";
  var ReciveDataUserEmail = "";
  var ReciveDataUserMobile = "";
  var ReciveDataUserStatus ="";
  var ReciveDataUserFullName ="";

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String FirstName,LastName,Mobile;
  var ProfileupdateStatus = "";
  var ProfileupdateMSG = "";

  var GetProfileDataStatus = "";
//---------------------------------------------------------------------------------------------------//
  String GetProfileDataurl ='http://192.168.0.200/anuj/ATMA/MyProfile.php';
  GetProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ReciveUserID = prefs.getString(Preferences.KEY_UserID).toString();
    ReciveUserEmail = prefs.getString(Preferences.KEY_Email).toString();
    ReciveUserFullName = prefs.getString(Preferences.KEY_FullName).toString();
    http.post(GetProfileDataurl, body: {
      "User_ID": ReciveUserID.toString(),
      "Token": GlobalStringText.Token
    }).then((resultGetProfileData) {
      print("User_ID"+ReciveUserID.toString());
      print("Token" + GlobalStringText.Token);
      print("statusCode" + resultGetProfileData.statusCode.toString());
      //print("resultbody" + resultGetProfileData.body);

//------------------------------------------------------------------------------------------------------------//
      setStatus(resultGetProfileData.statusCode == 200 ? resultGetProfileData.body : errMessage);
      //print("jsonresp ${resultGetProfileData.body}");
      data = json.decode(resultGetProfileData.body);

      GetProfileDataStatus = data["Status"].toString();

      if(GetProfileDataStatus == "true") {
        loading = true;
        final ExtractData = jsonDecode(resultGetProfileData.body);
        data = ExtractData["JSONDATA"];
        print(data.toString());
        setState(() {
          ReciveDataUserFirstName = data[0]["First_Name"];
          ReciveDataUserLastName = data[0]["Last_Name"];
          ReciveDataUserEmail = data[0]["Email"];
          ReciveDataUserMobile = data[0]["Mobile"];
          ReciveDataUserStatus = data[0]["Status"];
          ReciveDataUserFullName = data[0]["First_Name"]+" "+data[0]["Last_Name"];
        });
        setState(() {
          ProfileFirstNameController.text = ReciveDataUserFirstName;
          ProfileLastNameController.text = ReciveDataUserLastName;
          ProfileMobileNumberController.text = ReciveDataUserMobile;
        });
        return;
      }
      else if(GetProfileDataStatus == "false"){
        GetProfileDataStatusFalseAlert(context);
        return;
      }
//------------------------------------------------------------------------------------------------------------//
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

//-------------------------------------------UpdateProfileDataurl--------------------------------------------------------//
  String UpdateProfileDataurl ='http://192.168.0.200/anuj/ATMA/ProfileUpdate.php';
  UpdateProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ReciveUserID = prefs.getString(Preferences.KEY_UserID).toString();
    ReciveUserEmail = prefs.getString(Preferences.KEY_Email).toString();
    ReciveUserFullName = prefs.getString(Preferences.KEY_FullName).toString();
    http.post(UpdateProfileDataurl, body: {
      "User_ID": ReciveUserID.toString(),
      "Token": GlobalStringText.Token,
      "FirstName": ProfileFirstNameController.text.toString(),
      "LastName": ProfileLastNameController.text.toString(),
      "Mobile": ProfileMobileNumberController.text.toString(),
    }).then((resultUpdateProfileData) {
      print("User_ID"+ReciveUserID.toString());
      print("Token" + GlobalStringText.Token);
      print("FirstName" + ProfileFirstNameController.text.toString());
      print("LastName" + ProfileLastNameController.text.toString());
      print("Mobile" + ProfileMobileNumberController.text.toString());
      print("statusCode" + resultUpdateProfileData.statusCode.toString());
      print("resultbody" + resultUpdateProfileData.body);

//------------------------------------------------------------------------------------------------------------//
      setStatus(resultUpdateProfileData.statusCode == 200 ? resultUpdateProfileData.body : errMessage);
      //print("jsonresp ${resultGetProfileData.body}");
      dataProfileUpdate = json.decode(resultUpdateProfileData.body);

      ProfileupdateStatus = dataProfileUpdate["status"].toString();
      ProfileupdateMSG = dataProfileUpdate["MSG"].toString();

      if(ProfileupdateStatus == "true"){
        _displaySnackbar(context);
        ProfileUpdateStatusTrueAlert();
      }else if(ProfileupdateStatus == "false"){
        _displaySnackbar(context);
        ProfileUpdateStatusFalseAlert();
      }

//------------------------------------------------------------------------------------------------------------//
    }).catchError((error) {
      setStatus(error);
    });
  }
//----------------------------------------------------------------------------------------------//
  void  _displaySnackbar(BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(GlobalStringText.PleaseWait,style: TextStyle(color: ColorCode.WhiteTextColorCode),),
      backgroundColor: ColorCode.AppColorCode,
      ));
  }
//-----------------------------------------------------------------------------------------------//
  Future<void> ProfileUpdateStatusTrueAlert() async {
    print("StatusTrue");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(GlobalStringText.Thanks, textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 15.0,
                                                 color: ColorCode.AppColorCode,
                                                 fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(ProfileupdateMSG.toString(),
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
                _scaffoldKey.currentState.hideCurrentSnackBar();
                Navigator.pop(context, true);
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
//-----------------------------------------------------------------------------------------------//
  Future<void> ProfileUpdateStatusFalseAlert() async {
    print("StatusFalse");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(GlobalStringText.Warning, textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 15.0,
                                                 color: ColorCode.AppColorCode,
                                                 fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(ProfileupdateMSG.toString(),
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
                _scaffoldKey.currentState.hideCurrentSnackBar();
                Navigator.pop(context, true);
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
//----------------------------------------------------------------------------------------------//
  @override
  void initState() {
    this._checkInternetConnectivity(context);
    super.initState();
    this.GetProfileData();

  }
//----------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

//-----------------------------------------------------------------------------------//
    return  Scaffold(
      key: _scaffoldKey,
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
                              new Text("Mr."+ReciveDataUserFullName,
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
                                  ReciveDataUserEmail,
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
        title: Text(GlobalStringText.Account.toUpperCase(),style: TextStyle(
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
//-----------------------------------------------------------------------------------//
      body: new Container(
        height: _height,
        width: _width,
        margin: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: new Form(
            key: _key,
            autovalidate: _validate,
            child: Column(
              children: <Widget>[
                FormProfileImagetab(),
                SizedBox(height: 15.0,),
                FormTextField(),
                SizedBox(height: 15.0,),
                FormBtnSubmit(),
              ],
              ),
            ),
          ),
        ),
      );
  }
//----------------------------------------------------------------------------------------------//
  Widget FormProfileImagetab() {
    return new  FadeAnimation(2, Container(
      height: 120,
      color: ColorCode.AppColorCode,
      padding: EdgeInsets.only(top: 30.0),

      child: new Stack(fit: StackFit.loose, children: <Widget>[
        SizedBox(
          // height: 210,
          child: Column(
            children: [
              ListTile(
                title: Text(ReciveDataUserFullName.toUpperCase().toString(),style: TextStyle(fontSize: 13.0, color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold)),
                leading: new Container(
                    height: 100.0,
                    width: 100.0,
                    /*decoration: new BoxDecoration(
                                     //color: const Color(0xff7c94b6),
                                     borderRadius: BorderRadius.all(const Radius.circular(00.0)),
                                     border: Border.all(color: const Color(0xFF28324E)),
                                     ),*/
                    child: new Image.network("http://192.168.0.200/anuj/ATMA/images/noimage.jpg")
                    ),
                //subtitle: Text(GlobalStringText.Edit.toUpperCase().toString(),style: TextStyle(fontSize: 13.0, color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold, decoration: TextDecoration.underline,)),
                onTap: () {
                  print("d");
                  //Navigator.of(context).pushNamed(ProfileUpdate.tag);
                  // do something
                },
                ),
            ],

            ),
          ),
      ]),
      ),
                              );
  }
//------------------------------------------------------------------------------------------------------------//
  Widget FormTextField() {
    return new Column(
      children: <Widget>[
        new FadeAnimation(2, Container(

          child: new ListView(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            controller: _scrollController,
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 10.0,
                ),
//------------------------------------------------------------------------------------------------------------//
              new TextFormField(
                readOnly: false,
                controller: ProfileFirstNameController,
                validator: validateFirstName,
                onSaved: (String val) {
                  FirstName = val;
                },
                focusNode: myFocusNodeFirstName,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  suffixText: ReciveDataUserFirstName,
                  suffixStyle:TextStyle(fontSize: 12.0, color:ColorCode.AppColorCode),
                  hintText: ReciveDataUserFirstName.toString(),
                  filled: true,
                  hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                  prefixIcon: const Icon(Icons.person,  color:Color(0xFFCEA910),),
                  ),
                ),
              SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
              new TextFormField(
                readOnly: false,
                controller: ProfileLastNameController,
                validator: validateLastName,
                onSaved: (String val) {
                  LastName = val;
                },
                focusNode: myFocusNodeLastName,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  suffixText: ReciveDataUserLastName,
                  suffixStyle:TextStyle(fontSize: 12.0, color:ColorCode.AppColorCode),
                  hintText: ReciveDataUserLastName.toString(),
                  filled: true,
                  hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                  prefixIcon: const Icon(Icons.person,  color:Color(0xFFCEA910),),
                  prefixText: ' ',
                  ),
                ),
              SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
              new TextFormField(
                readOnly: false,
                controller: ProfileMobileNumberController,
                validator: validateMobile,
                onSaved: (String val) {
                  Mobile = val;
                },
                focusNode: myFocusNodeMobileNumber,
                keyboardType:TextInputType.numberWithOptions(),
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  suffixText: ReciveDataUserMobile,
                  suffixStyle:TextStyle(fontSize: 12.0, color:ColorCode.AppColorCode),
                  hintText: ReciveDataUserMobile.toString(),
                  filled: true,
                  hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                  prefixIcon: const Icon(Icons.phone_android,  color:Color(0xFFCEA910),),
                  prefixText: ' ',
                  ),
                ),
              SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
              new TextFormField(
                readOnly: true,
                keyboardType:TextInputType.numberWithOptions(),
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  suffixText: ReciveDataUserStatus,
                  suffixStyle:TextStyle(fontSize: 12.0, color:ColorCode.AppColorCode),
                  hintText: ReciveDataUserStatus.toString(),
                  filled: true,
                  hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                  prefixIcon: const Icon(FontAwesomeIcons.ban,  color:Color(0xFFCEA910),),
                  prefixText: ' ',
                  ),
                ),
            ],
            ),
          ),
                          ),
      ],
      );
  }
  //--------------------------------------------------------------------------------------------------------------------------------//
  Widget FormBtnSubmit() {
    return  FadeAnimation(2, Container(
        margin: EdgeInsets.only(left: 20.0,right: 20.0),
        child: Row(children: <Widget>[
          Expanded(
            child: Container(
              height: 50,
              child: new FlatButton.icon(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey)),
                color: ColorCode.AppColorCode,
                //color: Colors.red,
                icon: Icon(FontAwesomeIcons.fileExport,color: Colors.white,), //`Icon` to display
                label: Text(GlobalStringText.ProfileSubmit.toUpperCase(),style: TextStyle(fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.bold,)), //`Text` to display
                onPressed: (){
                  _sendToServer(context);
                },
                ),
              ),
            ),
          new Container(
            color: ColorCode.WhiteTextColorCode,
            height: 50.0,
            width: 1.0,
            ),
        ])
        ),
                          );
  }
  //-------------------------------------------------------------------------------------------------------------------//
  _sendToServer(BuildContext context) async {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("true");
      _checkInternetConnectivity(context);
      UpdateProfileData();
    } else {
      // validation error
      setState(() {
        print("Faield");
        _validate = true;
      });
    }
  }
  //--------------------------------------------------------------------------------------------------------//
  Future<void> GetProfileDataStatusFalseAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(GlobalStringText.Warning, textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 15.0,
                                                 color: ColorCode.AppColorCode,
                                                 fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(GlobalStringText.SomethingWentWrong.toString(),
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
                _scaffoldKey.currentState.hideCurrentSnackBar();
                /* Navigator.of(context).pop();*/
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(
                      )),
                  );
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
  //---------------------------------------------------------------------------------------------//
  String validateFirstName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "First Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }
  //----------------------------------------------------------------------------------------------------------------------//
  String validateLastName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Last Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }
  //----------------------------------------------------------------------------------------------------------------------//
  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if(value.length != 10){
      return "Mobile number must 10 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }
}
//----------------------------------------------------------------------------------------------//