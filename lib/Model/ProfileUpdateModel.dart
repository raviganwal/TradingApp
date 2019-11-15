class ProfileUpdateModel {
  bool status;
  String mSG;

  ProfileUpdateModel({this.status, this.mSG});

  ProfileUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mSG = json['MSG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['MSG'] = this.mSG;
    return data;
  }
}