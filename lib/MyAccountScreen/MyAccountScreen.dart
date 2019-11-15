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
  TextEditingController SignupFirstNameController = new TextEditingController();
  TextEditingController SignupLastNameController = new TextEditingController();
  TextEditingController SignupMobileNumberController = new TextEditingController();
  TextEditingController SignupEmailController = new TextEditingController();
  TextEditingController SignupPasswordController = new TextEditingController();
  final FocusNode myFocusNodeFirstName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();
  final FocusNode myFocusNodeMobileNumber = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String FirstName, LastName,MobileNumber,Email,Password, ConfirmPassword;
  var loading = true;
  String status = '';
  String errMessage = GlobalStringText.errMessage;
  var data;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//----------------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
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
                              new Text("Mr. "+
                                           "",
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
                                  "",
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
                ProfileImagetab,
                SizedBox(height: 15.0,),
                FormTextField(),
                SizedBox(height: 15.0,),
                FormBtnSubmit(),
                SizedBox(height: 20.0,),
              ],
              ),
            ),
          ),
        ),
      );
  }
//----------------------------------------------------------------------------------------------//
  final ProfileImagetab = new  Container(
    height: 120,
    color: ColorCode.AppColorCode,
    padding: EdgeInsets.only(top: 30.0),
    child: new Stack(fit: StackFit.loose, children: <Widget>[
      SizedBox(
        // height: 210,
        child: Column(
          children: [
            ListTile(
              title: Text("dd".toUpperCase().toString(),style: TextStyle(fontSize: 13.0, color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold)),
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
              subtitle: Text(GlobalStringText.Edit.toUpperCase().toString(),style: TextStyle(fontSize: 13.0, color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold, decoration: TextDecoration.underline,)),
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
    );
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
                focusNode: myFocusNodeFirstName,
                controller: SignupFirstNameController,
                validator: validateFirstName,
                onSaved: (String val) {
                  FirstName = val;
                },
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: 'Enter First Name',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                  //helperText: 'Keep it short, this is just a demo.',
                  labelText: 'First Name',labelStyle:
                new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                  prefixIcon: const Icon(Icons.person,  color:Color(0xFFCEA910),),
                  prefixText: ' ',
                  //suffixText: 'USD',
                  //suffixStyle: const TextStyle(color: Colors.green)
                  ),
                ),
              SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
              TextFormField(
                focusNode: myFocusNodeLastName,
                controller: SignupLastNameController,
                validator: validateLastName,
                onSaved: (String val) {
                  LastName = val;
                },
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: 'Enter Last Name',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                  //helperText: 'Keep it short, this is just a demo.',
                  labelText: 'Last Name',labelStyle:
                new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                  prefixIcon: const Icon(Icons.person, color:Color(0xFFCEA910),),
                  prefixText: ' ',
                  //suffixText: 'USD',
                  //suffixStyle: const TextStyle(color: Colors.green)
                  ),
                ),
              SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
              new TextFormField(
                focusNode: myFocusNodeMobileNumber,
                controller: SignupMobileNumberController,
                keyboardType: TextInputType.phone,
                validator: validateMobile,
                onSaved: (String val) {
                  MobileNumber = val;
                },
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: 'Enter Mobile Number',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                  //helperText: 'Keep it short, this is just a demo.',
                  labelText: 'Mobile Number',labelStyle:
                new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                  prefixIcon: const Icon(Icons.phone_android,  color:Color(0xFFCEA910),),
                  prefixText: ' ',
                  //suffixText: 'USD',
                  //suffixStyle: const TextStyle(color: Colors.green)
                  ),
                ),
              SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
              new TextFormField(
                focusNode: myFocusNodeEmail,
                controller: SignupEmailController,
                validator: validateEmail,
                onSaved: (String val) {
                  Email = val;
                },
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: 'Enter Email',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                  //helperText: 'Keep it short, this is just a demo.',
                  labelText: 'Email Address',labelStyle:
                new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                  prefixIcon: const Icon(Icons.email,  color:Color(0xFFCEA910),),
                  prefixText: ' ',
                  //suffixText: 'USD',
                  //suffixStyle: const TextStyle(color: Colors.green)
                  ),
                ),
              SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
/*              new TextFormField(
                autocorrect: false,
                obscureText: true,
                focusNode: myFocusNodePassword,
                controller: SignupPasswordController,
                validator: (value) =>
                value.isEmpty ? "Password can't be empty" : null,
                onSaved: (val) => Password = val,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: 'Enter Password',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                  //helperText: 'Keep it short, this is just a demo.',
                  labelText: 'Password',labelStyle:
                new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                  prefixIcon: const Icon(Icons.lock,  color:Color(0xFFCEA910),),
                  prefixText: ' ',
                  //suffixText: 'USD',
                  //suffixStyle: const TextStyle(color: Colors.green)
                  ),
                ),*/
/*//------------------------------------------------------------------------------------------------------------//

              TextFormField(
                autocorrect: false,
                obscureText: true,
                validator: (value) =>
                value.isEmpty ? "Password can't be empty" : null,
                onSaved: (val) => ConfirmPassword = val,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: 'Enter Confirm Password',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                  //helperText: 'Keep it short, this is just a demo.',
                  labelText: 'Confirm Password',labelStyle:
                new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                  prefixIcon: const Icon(Icons.lock, color:Color(0xFFCEA910),),
                  prefixText: ' ',
                  //suffixText: 'USD',
                  //suffixStyle: const TextStyle(color: Colors.green)
                  ),
                ),*/
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
                  //onPressed: _sendToServer(context),
                  onPressed: (){
                   // _sendToServer(context);
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
//-----------------------------------------------------------------------------------------------------------------------------------------//
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
  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }
  //---------------------------------------------------------------------------------------------------//
  String Signupurl ='http://192.168.0.200/anuj/ATMA/Registration.php';
  PostSignupData() {
    http.post(Signupurl, body: {
      "FirstName": SignupFirstNameController.text.toString(),
      "LastName": SignupLastNameController.text.toString(),
      "Email": SignupEmailController.text.toString(),
      "Mobile": SignupMobileNumberController.text.toString(),
      "Password": SignupPasswordController.text.toString(),
      "Token": GlobalStringText.Token
    }).then((resultSignup) {

//------------------------------------------------------------------------------------------------------------//
      setStatus(resultSignup.statusCode == 200 ? resultSignup.body : errMessage);
//------------------------------------------------------------------------------------------------------------//
      data = json.decode(resultSignup.body);
      if(!data['Status']==true) {
        _displaySnackbar(context);
        TrueAlert(context);
        return;
      }else if (!data['Status']==false){
        _displaySnackbar(context);
        _StatusFalseAlert(context);
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
  //-------------------------------------------------------------------------------------------------------------------//
  _sendToServer() async {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("true");
      PostSignupData();
    } else {
      // validation error
      setState(() {
        print("Faield");
        _validate = true;
      });
    }
  }
  //--------------------------------------------------------------------------------------//
  Future<void> TrueAlert(BuildContext context) async {
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
                Text(data['MSG'].toString(),
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
  //--------------------------------------------------------------------------------------------------------//
  Future<void> _StatusFalseAlert(BuildContext context) async {
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
                Text(data['MSG'].toString(),
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

//----------------------------------------------------------------------------------------------//
  void  _displaySnackbar(BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(GlobalStringText.PleaseWait,style: TextStyle(color: ColorCode.WhiteTextColorCode),),
      backgroundColor: ColorCode.AppColorCode,
      ));
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
    /*final prefs = await SharedPreferences.getInstance();
    prefs.remove(Preferences.KEY_UserStatus);
    Navigator.of(context).pushNamed(SplashScreen.tag);*/
  }
}
//----------------------------------------------------------------------------------------------//