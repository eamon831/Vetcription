
class Medicine {
  int id;
  String tradeName;
  String composition;
  String tradeDose;
  String company;
  String genericName;
  String comments;
  String packSize;
  String details;

  Medicine.name({
    this.id,
    this.tradeName,
    this.composition,
    this.tradeDose,
    this.company,
    this.genericName,
    this.comments,
    this.packSize,
    this.details});

  Medicine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tradeName = json['trade_name'];
    composition = json['composition'];
    tradeDose = json['trade_dose'];
    company = json['company'];
    genericName = json['generic_name'];
    comments = json['comments'];
    packSize = json['pack_size'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trade_name'] = this.tradeName;
    data['composition'] = this.composition;
    data['trade_dose'] = this.tradeDose;
    data['company'] = this.company;
    data['generic_name'] = this.genericName;
    data['comments'] = this.comments;
    data['pack_size'] = this.packSize;
    data['details'] = this.details;
    return data;
  }
}