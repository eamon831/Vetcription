class Disease{
  String name;
  String desCripTion;

  Disease(this.name, this.desCripTion);
  Disease.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desCripTion = json['description'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.desCripTion;

    return data;
  }
}