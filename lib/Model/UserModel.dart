class UserModel{
  String name,email,password,phone,regiNumber,userType;

  UserModel({this.name, this.email, this.password, this.phone, this.regiNumber});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email=json['email'];
    password=json['password'];
    phone=json['phone'];
    regiNumber=json['regi_number'];
    userType=json['user_type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['regi_number'] = this.regiNumber;
    data['user_type']=this.userType;
    return data;
  }
}