class AddPostModel {
  bool sTATUS;
  String mSG;
  int rECID;

  AddPostModel({this.sTATUS, this.mSG, this.rECID});

  AddPostModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    mSG = json['MSG'];
    rECID = json['RECID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    data['MSG'] = this.mSG;
    data['RECID'] = this.rECID;
    return data;
  }
}