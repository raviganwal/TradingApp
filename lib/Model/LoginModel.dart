class LoginModel {
  bool status;
  JSONDATA jSONDATA;
  String mSG;

  LoginModel({this.status, this.jSONDATA, this.mSG});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    jSONDATA = json['JSONDATA'] != null
        ? new JSONDATA.fromJson(json['JSONDATA'])
        : null;
    mSG = json['MSG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.jSONDATA != null) {
      data['JSONDATA'] = this.jSONDATA.toJson();
    }
    data['MSG'] = this.mSG;
    return data;
  }
}

class JSONDATA {
  String uSERID;
  String firstName;
  String lastName;
  String email;
  String mobile;
  String password;
  String organization;
  String profilePIC;
  String status;

  JSONDATA(
      {this.uSERID,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.password,
        this.organization,
        this.profilePIC,
        this.status});

  JSONDATA.fromJson(Map<String, dynamic> json) {
    uSERID = json['USER_ID'];
    firstName = json['First_Name'];
    lastName = json['Last_Name'];
    email = json['Email'];
    mobile = json['Mobile'];
    password = json['Password'];
    organization = json['Organization'];
    profilePIC = json['ProfilePIC'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USER_ID'] = this.uSERID;
    data['First_Name'] = this.firstName;
    data['Last_Name'] = this.lastName;
    data['Email'] = this.email;
    data['Mobile'] = this.mobile;
    data['Password'] = this.password;
    data['Organization'] = this.organization;
    data['ProfilePIC'] = this.profilePIC;
    data['Status'] = this.status;
    return data;
  }
}