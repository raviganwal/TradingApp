class MyPostModel {
  bool status;
  List<JSONDATA> jSONDATA;

  MyPostModel({this.status, this.jSONDATA});

  MyPostModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['JSONDATA'] != null) {
      jSONDATA = new List<JSONDATA>();
      json['JSONDATA'].forEach((v) {
        jSONDATA.add(new JSONDATA.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.jSONDATA != null) {
      data['JSONDATA'] = this.jSONDATA.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JSONDATA {
  String advID;
  String title;
  String type;
  String quantity;
  String colorPercentage;
  String paymentMode;
  String transport;
  String location;
  String catID;
  String subCatID;
  String price;
  String description;
  String features;
  String condition;
  String reasonOfSelling;
  String userID;
  String postTime;
  String visibleTo;
  String publishStatus;
  String image;

  JSONDATA(
      {this.advID,
        this.title,
        this.type,
        this.quantity,
        this.colorPercentage,
        this.paymentMode,
        this.transport,
        this.location,
        this.catID,
        this.subCatID,
        this.price,
        this.description,
        this.features,
        this.condition,
        this.reasonOfSelling,
        this.userID,
        this.postTime,
        this.visibleTo,
        this.publishStatus,
        this.image});

  JSONDATA.fromJson(Map<String, dynamic> json) {
    advID = json['Adv_ID'];
    title = json['Title'];
    type = json['Type'];
    quantity = json['Quantity'];
    colorPercentage = json['ColorPercentage'];
    paymentMode = json['PaymentMode'];
    transport = json['Transport'];
    location = json['Location'];
    catID = json['Cat_ID'];
    subCatID = json['SubCat_ID'];
    price = json['Price'];
    description = json['Description'];
    features = json['Features'];
    condition = json['Condition'];
    reasonOfSelling = json['Reason of Selling'];
    userID = json['User_ID'];
    postTime = json['Post_Time'];
    visibleTo = json['Visible_To'];
    publishStatus = json['Publish_Status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Adv_ID'] = this.advID;
    data['Title'] = this.title;
    data['Type'] = this.type;
    data['Quantity'] = this.quantity;
    data['ColorPercentage'] = this.colorPercentage;
    data['PaymentMode'] = this.paymentMode;
    data['Transport'] = this.transport;
    data['Location'] = this.location;
    data['Cat_ID'] = this.catID;
    data['SubCat_ID'] = this.subCatID;
    data['Price'] = this.price;
    data['Description'] = this.description;
    data['Features'] = this.features;
    data['Condition'] = this.condition;
    data['Reason of Selling'] = this.reasonOfSelling;
    data['User_ID'] = this.userID;
    data['Post_Time'] = this.postTime;
    data['Visible_To'] = this.visibleTo;
    data['Publish_Status'] = this.publishStatus;
    data['image'] = this.image;
    return data;
  }
}