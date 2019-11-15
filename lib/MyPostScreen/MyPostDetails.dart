import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:tradingapp/Component/GlobalStrintText.dart';
import 'package:tradingapp/Component/ColorCode.dart';
import 'package:tradingapp/Model/ProposalModel.dart';
import 'package:tradingapp/ProposalScreen/utils.dart';
import 'package:tradingapp/Preferences/Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
//----------------------------------------------------------------------------------------------//
class MyPostDetails extends StatefulWidget {
  static String tag = GlobalStringText.tagMyPostDetails;
  final String value1;
  final String value2;
  MyPostDetails({Key key,this.value1, this.value2}) : super(key: key);
  @override
  MyPostDetailsState createState() => new MyPostDetailsState();
}
//----------------------------------------------------------------------------------------------//
class MyPostDetailsState extends State<MyPostDetails>
    with SingleTickerProviderStateMixin {

//----------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFCEA910), Color(0xFF696D77)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,color: ColorCode.WhiteTextColorCode,
                  size: screenAwareSize(20.0, context),
                  ),
                onPressed: () {
                  Navigator.pop(context);
                },
                ),
              title: Text(widget.value2.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenAwareSize(18.0, context),
                                  fontFamily: "Montserrat-Bold")),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    size: screenAwareSize(20.0, context),
                    color: Colors.white,
                    ),
                  onPressed: () {},
                  )
              ],
              ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ProductScreenTopPart(),
                  ProductScreenBottomPart(),
                ],
                ),
              )));
  }
}
//----------------------------------------------------------------------------------------------------//
class ProductScreenTopPart extends StatefulWidget {
  @override
  _ProductScreenTopPartState createState() => new _ProductScreenTopPartState();
}
//-----------------------------------------------------------------------------------------//
class _ProductScreenTopPartState extends State<ProductScreenTopPart> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: screenAwareSize(245.0, context),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: screenAwareSize(18.0, context),
                right: screenAwareSize(18.0, context)
                ),
            child: Container(
              child: Image.network("http://192.168.0.200/anuj/ATMA/images/noimage.jpg",
                                       width: double.infinity,
                                       height: double.infinity,
                                       fit: BoxFit.contain),
              ),
            ),
        ],
        ),
      );
  }
}
//----------------------------------------------------------------------------------------------//
class ProductScreenBottomPart extends StatefulWidget {
  @override
  _ProductScreenBottomPartState createState() =>
      new _ProductScreenBottomPartState();
}

class _ProductScreenBottomPartState extends State<ProductScreenBottomPart> {
  bool isExpanded = false;
  int currentSizeIndex = 0;
  int currentColorIndex = 0;
  int _counter = 0;
//----------------------------------------------------------------------------------------------//
  var ReciveUserID="";
  var ReciveUserEmail="";
  var ReciveUserFullName="";
  String ReciveJsonAdv_ID ='';
  String ReciveType ='';
  String ReciveJsonCat_ID ='';
  String ReciveJsonSubCat_ID ='';
  String JsonReciveUser_ID ='';
  String RecivePrice ='';
  String ReciveDescription ='';
  String ReciveFeatures ='';
  String ReciveCondition ='';
  String ReciveReasonofSelling ='';
  String RecivePost_Time ='';
  String ReciveVisible_To ='';
  String RecivePublish_Status ='';
  String ReciveQuantity ='';
  String ReciveColorPercentage ='';
  String RecivePaymentMode ='';
  String ReciveTransport ='';
  String ReciveLocation ='';


  var loading = true;
  String status = '';
  String errMessage = GlobalStringText.errMessage;
  var data;
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//---------------------------------------------ProductDescription--------------------------------------//
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              GlobalStringText.ProductDescription,
              style: TextStyle(
                  color: ColorCode.WhiteTextColorCode,
                  fontSize: screenAwareSize(15.0, context),
                  fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: screenAwareSize(8.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              //right: screenAwareSize(18.0, context)
              ),
            child: AnimatedCrossFade(
              firstChild: Text(
                ReciveDescription.toString(),
                maxLines: 10,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              secondChild: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
              ),
            ),
          SizedBox(
            height: screenAwareSize(16.0, context),
            ),
//---------------------------------------ProductFeatures-----------------------------------------------------//
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              GlobalStringText.ProductFeatures,
              style: TextStyle(
                  color: ColorCode.WhiteTextColorCode,
                  fontSize: screenAwareSize(15.0, context),
                  fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: screenAwareSize(8.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              //right: screenAwareSize(18.0, context)
              ),
            child: AnimatedCrossFade(
              firstChild: Text(
                ReciveFeatures.toString(),
                maxLines: 10,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              secondChild: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
              ),
            ),
          SizedBox(
            height: screenAwareSize(16.0, context),
            ),
//---------------------------------------ProductCondition-----------------------------------------------------//
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              GlobalStringText.ProductCondition,
              style: TextStyle(
                  color: ColorCode.WhiteTextColorCode,
                  fontSize: screenAwareSize(15.0, context),
                  fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: screenAwareSize(8.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              //right: screenAwareSize(18.0, context)
              ),
            child: AnimatedCrossFade(
              firstChild: Text(
                ReciveCondition.toString(),
                maxLines: 10,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              secondChild: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
              ),
            ),
          SizedBox(
            height: screenAwareSize(16.0, context),
            ),
//---------------------------------------ProductReasonofSelling-----------------------------------------------------//
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              GlobalStringText.ProductReasonofSelling,
              style: TextStyle(
                  color: ColorCode.WhiteTextColorCode,
                  fontSize: screenAwareSize(15.0, context),
                  fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: screenAwareSize(8.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              //right: screenAwareSize(18.0, context)
              ),
            child: AnimatedCrossFade(
              firstChild: Text(
                ReciveReasonofSelling.toString(),
                maxLines: 10,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              secondChild: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
              ),
            ),
          SizedBox(
            height: screenAwareSize(16.0, context),
            ),
//---------------------------------------ProductType-----------------------------------------------------//
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              GlobalStringText.Type,
              style: TextStyle(
                  color: ColorCode.WhiteTextColorCode,
                  fontSize: screenAwareSize(15.0, context),
                  fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: screenAwareSize(8.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              //right: screenAwareSize(18.0, context)
              ),
            child: AnimatedCrossFade(
              firstChild: Text(
                ReciveType.toString(),
                maxLines: 10,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              secondChild: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
              ),
            ),
          SizedBox(
            height: screenAwareSize(16.0, context),
            ),
//---------------------------------------ProductQuantity-----------------------------------------------------//
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              GlobalStringText.Quantity,
              style: TextStyle(
                  color: ColorCode.WhiteTextColorCode,
                  fontSize: screenAwareSize(15.0, context),
                  fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: screenAwareSize(8.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              //right: screenAwareSize(18.0, context)
              ),
            child: AnimatedCrossFade(
              firstChild: Text(
                ReciveQuantity.toString(),
                maxLines: 10,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              secondChild: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
              ),
            ),
          SizedBox(
            height: screenAwareSize(16.0, context),
            ),
//---------------------------------------ProductColorPercentage-----------------------------------------------------//
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              GlobalStringText.ColorPercentage,
              style: TextStyle(
                  color: ColorCode.WhiteTextColorCode,
                  fontSize: screenAwareSize(15.0, context),
                  fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: screenAwareSize(8.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              //right: screenAwareSize(18.0, context)
              ),
            child: AnimatedCrossFade(
              firstChild: Text(
                ReciveColorPercentage.toString(),
                maxLines: 10,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              secondChild: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
              ),
            ),
          SizedBox(
            height: screenAwareSize(16.0, context),
            ),
//---------------------------------------ProductPaymentMode-----------------------------------------------------//
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              GlobalStringText.PaymentMode,
              style: TextStyle(
                  color: ColorCode.WhiteTextColorCode,
                  fontSize: screenAwareSize(15.0, context),
                  fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: screenAwareSize(8.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              //right: screenAwareSize(18.0, context)
              ),
            child: AnimatedCrossFade(
              firstChild: Text(
                RecivePaymentMode.toString(),
                maxLines: 10,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              secondChild: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
              ),
            ),
          SizedBox(
            height: screenAwareSize(16.0, context),
            ),
//---------------------------------------ProductTransport-----------------------------------------------------//
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              GlobalStringText.Transport,
              style: TextStyle(
                  color: ColorCode.WhiteTextColorCode,
                  fontSize: screenAwareSize(15.0, context),
                  fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: screenAwareSize(8.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              //right: screenAwareSize(18.0, context)
              ),
            child: AnimatedCrossFade(
              firstChild: Text(
                ReciveTransport.toString(),
                maxLines: 10,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              secondChild: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
              ),
            ),
          SizedBox(
            height: screenAwareSize(16.0, context),
            ),
//---------------------------------------ProductLocation-----------------------------------------------------//
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              GlobalStringText.Location,
              style: TextStyle(
                  color: ColorCode.WhiteTextColorCode,
                  fontSize: screenAwareSize(15.0, context),
                  fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: screenAwareSize(8.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              //right: screenAwareSize(18.0, context)
              ),
            child: AnimatedCrossFade(
              firstChild: Text(
                ReciveLocation.toString(),
                maxLines: 10,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              secondChild: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-Medium"),
                ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
              ),
            ),
//-------------------------------------Post_Time&Publish_Status------------------------------------------------------------//
          SizedBox(
            height: screenAwareSize(12.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
                left: screenAwareSize(15.0, context),
                right: screenAwareSize(75.0, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(RecivePost_Time.toString(),
                       style: TextStyle(
                           color: ColorCode.WhiteTextColorCode,
                           fontSize: screenAwareSize(15.0, context),
                           fontWeight: FontWeight.bold),),
                Text(RecivePublish_Status.toString(),
                         style: TextStyle(
                             color: ColorCode.AppColorCode,
                             fontSize: screenAwareSize(12.0, context),
                             fontFamily: "Montserrat-SemiBold"))
              ],
              ),
            ),
//-------------------------------------Price------------------------------------------------------------//
          SizedBox(
            height: screenAwareSize(12.0, context),
            ),
          Padding(
            padding: EdgeInsets.only(
                left: screenAwareSize(15.0, context),
                right: screenAwareSize(75.0, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(GlobalStringText.Price.toString(),
                       style: TextStyle(
                           color: ColorCode.WhiteTextColorCode,
                           fontSize: screenAwareSize(15.0, context),
                           fontWeight: FontWeight.bold),),
                Text("\$  "+RecivePrice.toString(),
                       style: TextStyle(
                           color: ColorCode.WhiteTextColorCode,
                           fontSize: screenAwareSize(15.0, context),
                           fontWeight: FontWeight.bold),)
              ],
              ),
            ),
//--------------------------------------------------------------------------------------------------------------------//
          Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: screenAwareSize(10.0, context),right: screenAwareSize(10.0, context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: screenAwareSize(10.0, context),
                        ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          color: Color(0xFFCEA910),
                          padding: EdgeInsets.symmetric(
                            vertical: screenAwareSize(14.0, context),
                            ),
                          onPressed: () {},
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: screenAwareSize(0.0, context)),
                              child: Text("Add To Cart",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                  screenAwareSize(15.0, context))),
                              ),
                            ),
                          ),
                        )
                    ],
                    ),
                  ),
                Positioned(
                  right: -40.0,
                  bottom: -60.0,
                  child: Image.asset("assets/cart.png",
                                         width: screenAwareSize(190.0, context),
                                         height: screenAwareSize(155.0, context),
                                         fit: BoxFit.cover),
                  ),
              ],
              ),
            )
        ],
        ),
      );
  }
//----------------------------------------------------------------------------------------------//
  String MyPostDetailsurl ='http://192.168.0.200/anuj/ATMA/MyADV.php';
  fetchMyPostDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ReciveUserID = prefs.getString(Preferences.KEY_UserID).toString();
    ReciveUserEmail = prefs.getString(Preferences.KEY_Email).toString();
    ReciveUserFullName = prefs.getString(Preferences.KEY_FullName).toString();
    http.post(MyPostDetailsurl, body: {
      "Token": GlobalStringText.Token,
      "User_ID":ReciveUserID.toString(),
    }).then((resultMyPostDetails) {
      print("Url"+MyPostDetailsurl);
      setStatus(resultMyPostDetails.statusCode == 200 ? resultMyPostDetails.body : errMessage);
      print("jsonresp ${resultMyPostDetails.body}");
      data = json.decode(resultMyPostDetails.body);

      if(!data['Status']) {
        /*_StatusFalseAlert(context);
        loading = false;
        return;*/
      }
      else{
        setState(() {
          var extractdata = json.decode(resultMyPostDetails.body);
          data = extractdata["JSONDATA"];
          ReciveJsonAdv_ID = data[0]["Adv_ID"].toString();
          ReciveType = data[0]["Type"].toString();
          ReciveJsonCat_ID = data[0]["Cat_ID"].toString();
          ReciveJsonSubCat_ID = data[0]["SubCat_ID"].toString();
          RecivePrice = data[0]["Price"].toString();
          ReciveDescription = data[0]["Description"].toString();
          ReciveFeatures = data[0]["Features"].toString();
          ReciveCondition = data[0]["Condition"].toString();
          ReciveReasonofSelling = data[0]["Reason_of_Selling"].toString();
          JsonReciveUser_ID = data[0]["User_ID"].toString();
          RecivePost_Time = data[0]["Post_Time"].toString();
          ReciveVisible_To = data[0]["Visible_To"].toString();
          RecivePublish_Status = data[0]["Publish_Status"].toString();
          ReciveQuantity = data[0]["Quantity"].toString();
          ReciveColorPercentage = data[0]["ColorPercentage"].toString();
          RecivePaymentMode = data[0]["PaymentMode"].toString();
          ReciveTransport = data[0]["Transport"].toString();
          ReciveLocation = data[0]["Location"].toString();
          ReciveType = data[0]["Type"].toString();

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
//----------------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    this.fetchMyPostDetails();
  }
}
//----------------------------------------------------------------------------------------------//