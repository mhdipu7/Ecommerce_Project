class ReviewerProfileModel {
  int? id;
  String? cusName;

  ReviewerProfileModel({this.id, this.cusName});

  ReviewerProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cusName = json['cus_name'];
  }
}