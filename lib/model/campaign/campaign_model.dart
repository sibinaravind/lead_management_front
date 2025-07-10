class CampaignModel {
  String? sId;
  String? title;
  String? startDate;
  String? image;
  String? createdAt;

  CampaignModel(
      {this.sId, this.title, this.startDate, this.image, this.createdAt});

  CampaignModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    startDate = json['startDate'];
    image = json['image'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['startDate'] = this.startDate;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
