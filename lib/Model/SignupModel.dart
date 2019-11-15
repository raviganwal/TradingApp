class SignupModel {
  bool status;
  String mSG;

  SignupModel({this.status, this.mSG});

  SignupModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    mSG = json['MSG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['MSG'] = this.mSG;
    return data;
  }
}