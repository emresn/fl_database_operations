class UserModel {
  int? id;
  String? name;
  int? age;

  UserModel({this.id, this.name, this.age});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], name: json['name'], age: json['age']);
  }

  Map<String, dynamic> toMap(UserModel userModel) {
    return {"id": userModel.id, "name": userModel.name, "age": userModel.age};
  }

  factory UserModel.demo() {
    return UserModel(name: "Leanne Graham", age: 26);
  }
}
