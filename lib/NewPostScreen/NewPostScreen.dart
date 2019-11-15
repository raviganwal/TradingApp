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
import 'package:tradingapp/Model/ProposalModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:tradingapp/NewPostScreen/User.dart';
import 'package:tradingapp/ProposalScreen/ProposalScreenDetails.dart';
import 'package:tradingapp/Preferences/Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradingapp/SplashScreen/SplashScreen.dart';
//-----------------------------------------------------------------------------------------//
class NewPostScreen extends StatefulWidget {
  static String tag = GlobalStringText.tagNewPostScreen;

  @override
  _NewPostScreenState createState() {
    return new _NewPostScreenState();
  }
}
//-----------------------------------------------------------------------------------------//
class _NewPostScreenState extends State<NewPostScreen>{
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

  TextEditingController TitleController = new TextEditingController();
  TextEditingController DescriptionController = new TextEditingController();
  TextEditingController QuantityController = new TextEditingController();
  TextEditingController PriceController = new TextEditingController();
  TextEditingController TransportController = new TextEditingController();
  TextEditingController LocationController = new TextEditingController();


  final FocusNode myFocusNodeTitle = FocusNode();
  final FocusNode myFocusNodeDescription = FocusNode();
  final FocusNode myFocusNodeQuantity = FocusNode();
  final FocusNode myFocusNodePrice = FocusNode();
  final FocusNode myFocusNodeTransport = FocusNode();
  final FocusNode myFocusNodeLocation = FocusNode();

  ScrollController _scrollController = new ScrollController();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  String Title,Description,Quantity,Transport,Location,Price;

  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;
  bool _isChecked = false;
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  User selectedUser;
  int selectedRadio;
  int selectedRadioTile;

  List<ColorsParent> _colors = ColorsParent.getColors();
  List<DropdownMenuItem<ColorsParent>> _dropdownMenuItems1;
  ColorsParent _selectedColor;
//----------------------------------------------------------------------------------------------//
  @override
  void initState() {
    this._checkInternetConnectivity(context);
    this.ReciveUserdetails();
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;

    _dropdownMenuItems1 = buildDropdownMenuItems1(_colors);
    _selectedColor = _dropdownMenuItems1[0].value;

    selectedRadio = 0;
    selectedRadioTile = 0;

    super.initState();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }
//----------------------------------------------------------------------------------------------//
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
//----------------------------------------------------------------------------------------------//
  setSelectedUser(User user) {
    setState(() {
      selectedUser = user;
    });
  }
  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
          ),
        );
    }
    return items;
  }
//----------------------------------------------------------------------------------------------//
  List<DropdownMenuItem<ColorsParent>> buildDropdownMenuItems1(List companies) {
    List<DropdownMenuItem<ColorsParent>> items = List();
    for (ColorsParent company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.ColorName),
          ),
        );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }
  onChangeDropdownItem1(ColorsParent selectedcolor) {
    setState(() {
      _selectedColor = selectedcolor;
    });
  }
  Future<void> ReciveUserdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ReciveUserID = prefs.getString(Preferences.KEY_UserID).toString();
    ReciveUserEmail = prefs.getString(Preferences.KEY_Email).toString();
    ReciveUserFullName = prefs.getString(Preferences.KEY_FullName).toString();
    print("Akash"+ReciveUserFullName);
    print("Email"+ReciveUserEmail);
  }
//---------------------------------------------------------------------------------------------------//
  String PostAddurl ='http://192.168.0.200/anuj/ATMA/NewAdvPost.php';
  PostAdd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ReciveUserID = prefs.getString(Preferences.KEY_UserID).toString();
    ReciveUserEmail = prefs.getString(Preferences.KEY_Email).toString();
    ReciveUserFullName = prefs.getString(Preferences.KEY_FullName).toString();
    print("Akash"+ReciveUserFullName);
    http.post(PostAddurl, body: {
      "Title": TitleController.text.toString(),
      "Description": DescriptionController.text.toString(),
      "Quantity": QuantityController.text.toString(),
      "Price": PriceController.text.toString(),
      "Transport": TransportController.text.toString(),
      "Location": LocationController.text.toString(),
      "Type": _selectedCompany.name.toString(),
      "User_ID": ReciveUserID.toString(),
      "DispatchOrStore": ReciveUserID.toString(),
      "ColorPercentage": _selectedColor.ColorName.toString(),
      "Token": GlobalStringText.Token
    }).then((resultPostAdd) {
      print("User_ID"+ReciveUserID.toString());
      print("uploadEndPoint"+PostAddurl.toString());
      print("Title"+TitleController.text.toString());
      print("Price"+PriceController.text.toString());
      print("Transport"+TransportController.text.toString());
      print("Quantity"+QuantityController.text.toString());
      print( "Description"+ DescriptionController.text.toString());
      print( "Location"+ LocationController.text.toString());
      print( "DispatchOrStore"+ ReciveUserID.toString());
      print( "Type"+ _selectedCompany.name.toString());
      print( "ColorPercentage"+_selectedColor.ColorName.toString());
      print("Token" + GlobalStringText.Token);
      print("statusCode" + resultPostAdd.statusCode.toString());
      print("resultbody" + resultPostAdd.body);
      //return result.body.toString();
//------------------------------------------------------------------------------------------------------------//
      setStatus(resultPostAdd.statusCode == 200 ? resultPostAdd.body : errMessage);
      var data = json.decode(resultPostAdd.body);

    }).catchError((error) {
      setStatus(error);
    });
  }
//----------------------------------------------------------------------------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
  //-----------------------------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    //------------------------------------------------------------------------------------------------------------//
    Widget FormTextField() {
      return new Column(
        children: <Widget>[
          new FadeAnimation(2, Container(
            child: new ListView(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              controller: _scrollController,
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: 0.0,
                  ),
//------------------------------------------------------------------------------------------------------------//
                new TextFormField(
                  focusNode: myFocusNodeTitle,
                  controller: TitleController,
                  validator: validateTitle,
                  onSaved: (String val) {
                    Title = val;
                  },
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    hintText: 'Enter Title Name',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                    //helperText: 'Keep it short, this is just a demo.',
                    labelText: 'Title',labelStyle:
                  new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                    prefixIcon: const Icon(FontAwesomeIcons.heading,  color:Color(0xFFCEA910),),
                    prefixText: ' ',
                    //suffixText: 'USD',
                    //suffixStyle: const TextStyle(color: Colors.green)
                    ),
                  ),
                SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
                TextFormField(
                  focusNode: myFocusNodeDescription,
                  controller: DescriptionController,
                  validator: validateDescription,
                  onSaved: (String val) {
                    Description = val;
                  },
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    hintText: 'Enter Description',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                    //helperText: 'Keep it short, this is just a demo.',
                    labelText: 'Description',labelStyle:
                  new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                    prefixIcon: const Icon(FontAwesomeIcons.info, color:Color(0xFFCEA910),),
                    prefixText: ' ',
                    //suffixText: 'USD',
                    //suffixStyle: const TextStyle(color: Colors.green)
                    ),
                  ),
                SizedBox(height: 10.0),

//------------------------------------------------------------------------------------------------------------//
                new TextFormField(
                  focusNode: myFocusNodeQuantity,
                  controller: QuantityController,
                  validator: validateQuantity,
                  onSaved: (String val) {
                    Quantity = val;
                  },
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    hintText: 'Enter Quantity',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                    //helperText: 'Keep it short, this is just a demo.',
                    labelText: 'Quantity',labelStyle:
                  new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                    prefixIcon: const Icon(FontAwesomeIcons.weight,  color:Color(0xFFCEA910),),
                    prefixText: ' ',
                    //suffixText: 'USD',
                    //suffixStyle: const TextStyle(color: Colors.green)
                    ),
                  ),
                SizedBox(height: 15.0),
//------------------------------------------------------------------------------------------------//
                new TextFormField(
                  focusNode: myFocusNodePrice,
                  controller: PriceController,
                  keyboardType:TextInputType.numberWithOptions(),
                  validator: validateReasonofPrice,
                  onSaved: (String val) {
                    Price = val;
                  },
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    hintText: 'Enter Price',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.AppColorCode),
                    //helperText: 'Keep it short, this is just a demo.',
                    labelText: 'Enter Price',labelStyle:
                  new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                    prefixIcon: const Icon(FontAwesomeIcons.rupeeSign,  color:Color(0xFFCEA910),),
                    prefixText: ' ',
                    //suffixText: 'USD',
                    //suffixStyle: const TextStyle(color: Colors.green)
                    ),
                  ),
                SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
          new Container(
            color: Colors.white24,
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    GlobalStringText.Type.toUpperCase(),textAlign: TextAlign.start,
                    style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: ColorCode.AppColorCode),
                    ),

                  subtitle: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DropdownButton(
                          isExpanded: true,
                          value: _selectedCompany,
                          items: _dropdownMenuItems,
                          onChanged: onChangeDropdownItem,
                          ),
                      ]),
                  )

              ],
              ),

            ),
                SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
          new Container(
            color: Colors.white24,
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    GlobalStringText.Colorpercentage.toUpperCase(),textAlign: TextAlign.start,
                    style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color:ColorCode.AppColorCode),
                    ),

                  subtitle: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DropdownButton(
                          isExpanded: true,
                          value: _selectedColor,
                          items: _dropdownMenuItems1,
                          onChanged: onChangeDropdownItem1,
                          ),
                      ]),
                  )

              ],
              ),

            ),
                SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
        new Container(
          color: Colors.white24,
          child: new Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    child: new Image(
                      image: new AssetImage("assets/images/greenstar.png"),
                      ),
                    margin: const EdgeInsets.only(left:30.0),
                    width: 20.0,
                    height: 20.0,
                    ),
                  new Checkbox(
                    activeColor:ColorCode.AppColorCode,
                    value: _isChecked,
                    onChanged: (val) {
                      setState(() {
                        _isChecked = val;
                        //Navigator.of(context).pushNamed(MobileNo.tag);
                        print('English_Language');
                      });
                    },
                    ),
                  new Container(
                    child: new Image(
                      image: new AssetImage("assets/images/lace.png"),
                      ),
                    margin: const EdgeInsets.only(left:40.0),
                    width: 20.0,
                    height: 20.0,
                    ),
                  new Checkbox(
                    activeColor:ColorCode.AppColorCode,
                    value: _isChecked1,
                    onChanged: (val) {
                      setState(() {
                        _isChecked1 = val;
                        //Navigator.of(context).pushNamed(MobileNo.tag);
                        print('English_Language');
                      });
                    },
                    ),
                  new Container(
                    child: new Image(
                      image: new AssetImage("assets/images/red.png"),
                      ),
                    margin: const EdgeInsets.only(left:50.0),
                    width: 20.0,
                    height: 20.0,
                    ),
                  new Checkbox(
                    activeColor:ColorCode.AppColorCode,
                    value: _isChecked2,
                    onChanged: (val) {
                      setState(() {
                        _isChecked2 = val;
                        //Navigator.of(context).pushNamed(MobileNo.tag);
                        print('English_Language');
                      });
                    },
                    ),
                ],
                ),
            ],
            ),
          ),
                SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
        new Container(
          color: Colors.white24,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child:
                    RadioListTile(
                      value: 1,
                      groupValue: selectedRadioTile,
                      title: Text(""),
                      subtitle: Text(""),
                      onChanged: (val) {
                        print("Radio Tile pressed $val");

                        setSelectedRadioTile(val);
                      },
                      activeColor:ColorCode.AppColorCode,
                      secondary: OutlineButton(
                        child: Text("Dispatch"),
                        onPressed: () {
                          print("Say Hello");
                        },
                        //onPressed: _neverSatisfied,
                        ),
                      selected: true,
                      ),
                    ),
                  Flexible(
                    fit: FlexFit.loose,
                    child:
                    RadioListTile(
                      value: 2,
                      groupValue: selectedRadioTile,
                      title: Text(""),
                      subtitle: Text(""),
                      onChanged: (val) {
                        // print("Radio Tile pressed $val");
                        setSelectedRadioTile(val);
                      },
                      activeColor:ColorCode.AppColorCode,
                      secondary: OutlineButton(
                        child: Text("Store"),
                        onPressed: () {
                          // print("Say Hello");
                        },
                        ),
                      selected: false,
                      ),
                    )
                ],
                ),
            ],
            ),
          ),
                SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
                new TextFormField(
                  focusNode: myFocusNodeTransport,
                  controller: TransportController,
                  validator: validateTransport,
                  onSaved: (String val) {
                    Transport = val;
                  },
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    hintText: 'Enter Transport',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                    //helperText: 'Keep it short, this is just a demo.',
                    labelText: 'Transport',labelStyle:
                  new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                    prefixIcon: const Icon(FontAwesomeIcons.truck,  color:Color(0xFFCEA910),),
                    prefixText: ' ',
                    //suffixText: 'USD',
                    //suffixStyle: const TextStyle(color: Colors.green)
                    ),
                  ),
                SizedBox(height: 10.0),
//------------------------------------------------------------------------------------------------------------//
                new TextFormField(
                  focusNode: myFocusNodeLocation,
                  controller: LocationController,
                  validator: validateLocation,
                  onSaved: (String val) {
                    Location = val;
                  },
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    hintText: 'Enter Location',hintStyle: TextStyle(fontSize: 12.0, color:ColorCode.BlackTextColorCode),
                    //helperText: 'Keep it short, this is just a demo.',
                    labelText: 'Location',labelStyle:
                  new TextStyle(fontSize: 14.0, color:ColorCode.BlackTextColorCode,fontWeight: FontWeight.w300),
                    prefixIcon: const Icon(FontAwesomeIcons.locationArrow,  color:Color(0xFFCEA910),),
                    prefixText: ' ',
                    //suffixText: 'USD',
                    //suffixStyle: const TextStyle(color: Colors.green)
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
    Widget FormBtnCancelSave() {
      return  FadeAnimation(2, Container(
          margin: EdgeInsets.only(left: 20.0,right: 20.0),
          child: Row(children: <Widget>[
            Expanded(
              child: RaisedButton(
                color: Color(0xFFCEA910),
                child:  Text(
                  GlobalStringText.Post.toUpperCase(),
                  style: TextStyle(color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold,fontSize: _large? 14: (_medium? 12: 10)),
                  ),
                onPressed: () {
                  _sendToServer();
                },
                ),
              ),
            new Container(
              color: ColorCode.WhiteTextColorCode,
              height: 50.0,
              width: 2.0,
              ),
            Expanded(
              child: RaisedButton(
                color: Color(0xFFCEA910),
                child:  Text(
                  GlobalStringText.Cancle.toUpperCase(),
                  style: TextStyle(color: ColorCode.WhiteTextColorCode,fontWeight: FontWeight.bold,fontSize: _large? 14: (_medium? 12: 10)),
                  ),
                onPressed: () {
                  // _sendToServer();
                },
                ),
              ),

          ])
          ),
                            );
    }
//------------------------------------------------------------------------------------------------------------//
    return new WillPopScope(
      onWillPop: () async {
        Future.value(
            false); //return a `Future` with false value so this route cant be popped or closed.
      },
      child: new Scaffold(
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
          title: Text(GlobalStringText.newpost.toUpperCase(),style: TextStyle(
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
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: new Form(
              key: _key,
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15.0,),
                  FormTextField(),
                  SizedBox(height: 15.0,),
                  FormBtnCancelSave(),
                ],
                ),
              ),
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
//-----------------------------------------------------------------------------------------------------------------------------------------//
  String validateTitle(String value) {
    String patttern = r'';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Title is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Title must be Need";
    }
    return null;
  }
//-----------------------------------------------------------------------------------------------------------------------------------------//
  String validateDescription(String value) {
    String patttern = r'';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Description is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Description must be Need";
    }
    return null;
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------//
  String validateQuantity(String value) {
    String patttern = r'';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Quantity is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Quantity must be Need";
    }
    return null;
  }

  //-----------------------------------------------------------------------------------------------------------------------------------------//
  String validateTransport(String value) {
    String patttern = r'';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Quantity is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Quantity must be Need";
    }
    return null;
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------//
  String validateLocation(String value) {
    String patttern = r'';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Location is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Location must be Need";
    }
    return null;
  }
  //----------------------------------------------------------------------------------------------------------------------//
  String validateReasonofPrice(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Reason of Selling is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Reason of Selling must be 0-9";
    }
    return null;
  }
//------------------------------------------------------------------------------------------------------------//
  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      PostAdd();
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
//-----------------------------------------------------------------------------------------//
class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Select Type'),
      Company(2, 'Flower'),
      Company(3, 'Seed'),
      Company(4, 'Fruit'),
      Company(5, 'orange'),
    ];
  }
}

class ColorsParent {
  int id;
  String ColorName;

  ColorsParent(this.id, this.ColorName);

  static List<ColorsParent> getColors() {
    return <ColorsParent>[
      ColorsParent(1, 'Select Color'),
      ColorsParent(2, '0-10'),
      ColorsParent(3, '10-20'),
      ColorsParent(4, '20-30'),
      ColorsParent(5, '30-40'),
      ColorsParent(6, '40-50'),
      ColorsParent(7, '50-60'),
      ColorsParent(8, '60-70'),
      ColorsParent(9, '70-80'),
      ColorsParent(10, '80-90'),
      ColorsParent(11, '90-100'),
    ];
  }
}
class GroupModel {
  String text;
  int index;
  GroupModel({this.text, this.index});
}