import 'package:flutter/material.dart';
import 'package:tradingapp/Component/ColorCode.dart';
import 'package:tradingapp/Component/GlobalStrintText.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
//--------------------------------------------------------------------------------------//
class ChatMessageDetails extends StatefulWidget {
  static String tag = GlobalStringText.tagChatMessage;

  final String value1;
  final String value2;

  ChatMessageDetails({Key key, this.value1, this.value2}) : super(key: key);
  @override
  State createState() => new ChatMessageDetailsState();
}
//--------------------------------------------------------------------------------------//
class ChatMessageDetailsState extends State<ChatMessageDetails> {
  final TextEditingController _textController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String AppReciveUserID="";
  String AppReciveUserFullName="";
  ScrollController _scrollController = new ScrollController();
  var ChangePageFinalReciveNotEqualMessage;
  var ChangePageFinalReciveMessage;

  @override
  void dispose() {
    // SendChatController.dispose();
    super.dispose();
  }
//-------------------------------------------------------------------------------------------//
  @override
  void initState() {
    // this._checkInternetConnectivity();
    super.initState();
  }
//---------------------------------------------------------------------------------------------------//
  //---------------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Timer(Duration(milliseconds: 1), () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
    Widget _textComposerWidget() {
      return new IconTheme(
        data: new IconThemeData(color: ColorCode.AppColorCode),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
                  controller: _textController,
                  //onSubmitted: _handleSubmitted,
                  //onSubmitted: EditPostUpadte(),
                  ),
                ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send,color: ColorCode.AppColorCode,),
                    onPressed: () {
                      //EditPostUpadte();
                      //Toast.show("Message Sent   "+_textController.text.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                    }
                    ),
                )
            ],
            ),
          ),
        );
    }
//--------------------------------------------------------------------------------------//
    return   Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(widget.value2.toString().toUpperCase(),style: TextStyle(color: ColorCode.WhiteTextColorCode),),
        centerTitle: true,
        actions: <Widget>[
          new Stack(
            children: <Widget>[
              new IconButton(
                padding: new EdgeInsets.all(15.0),
                icon: new Icon(
                  Icons.notifications,
                  color: Colors.white,
                  ),
                /*onPressed: () {
                    //print("hello"+id.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryTotalAddList(
                            value: Userid.toString(),
                            )),
                      );
                  },*/
                ),
              new Positioned(
                  child: new Stack(
                    children: <Widget>[
                      new Icon(null),
                      new Positioned(
                          top: 5.0,
                          right: 5,
                          child: new Center(
                            child: new Text(
                              "".toString(),
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500),
                              ),
                            )),
                    ],
                    )),
            ],
            ),
        ],
        ),
      backgroundColor: Colors.white,
      //body: ChatLayOut,
      //body: ChatLayOut,
      body: new  Column(
        children: <Widget>[
          /*loading
              ? Center(
            child: CircularProgressIndicator(),
            ):*/
          new Flexible(
            child: new ListView.builder(
              controller: _scrollController,
              padding: new EdgeInsets.all(8.0),
              reverse: false,
             // itemCount: _ChatListMessage == null ? 0 : _ChatListMessage.length,
              itemBuilder: (BuildContext context, i) {
              //  final ChatUserMessage = _ChatListMessage[i];
               // FinalReciveFrom_ID = ChatUserMessage.From_ID;
               // FinalReciveMessage = ChatUserMessage.Message;
                //print("AppReciveUserID= "+AppReciveUserID);
                //print("FinalReciveFrom_ID= "+FinalReciveFrom_ID);

          /*      if(AppReciveUserID == FinalReciveFrom_ID ){
                  // print("FinalReciveEqualMessage");
                  FinalReciveMessage = ChatUserMessage.Message.toString();
                  // print("FinalReciveEqualMessage= "+FinalReciveMessage.toString());



                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          ChatUserMessage.Message_TIME,
                          style:
                          TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        Bubble(
                          message:FinalReciveMessage.toString(),
                          isMe: false,
                          ),
                      ],
                      ),
                    );
                }*/


//-----------------------------------------------------------------------------------------------//
               /* else if(AppReciveUserID != FinalReciveFrom_ID){
                  FinalReciveNotEqualMessage = ChatUserMessage.Message.toString();
                  //print("FinalReciveNotEqualMessage"+FinalReciveNotEqualMessage);
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          ChatUserMessage.Message_TIME,
                          style:
                          TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        Bubble(
                          message:FinalReciveNotEqualMessage.toString(),
                          isMe: true,
                          ),
                      ],
                      ),
                    );
                }*/
              },

              ),
            ),
          new Divider(
            height: 1.0,
            ),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
              ),
            child: _textComposerWidget(),
            ),
        ],
        ),
      );
  }
//--------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------//
}
class Bubble extends StatelessWidget {
  final bool isMe;
  final String message;

  Bubble({this.message, this.isMe});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: isMe
                      ? LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.1,
                        1
                      ],
                      colors: [
                        Color(0xFFF6D365),
                        Color(0xFFFDA085),
                      ])
                      : LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.1,
                        1
                      ],
                      colors: [
                        Color(0xFFEBF5FC),
                        Color(0xFFEBF5FC),
                      ]),
                  borderRadius: isMe
                      ? BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(15),
                    )
                      : BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(0),
                    ),
                  ),
                child: Column(
                  crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      message,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.grey,
                        ),
                      )
                  ],
                  ),
                ),
            ],
            )
        ],
        ),
      );
  }
}