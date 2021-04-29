import 'dart:convert';

class UserDetailModel {
  String? id;
  String? phoneNumber;
  String? name;
  String? email;
  String? posCustomerId;

  UserDetailModel({
    this.id,
    this.phoneNumber,
    this.name,
    this.email,
    this.posCustomerId,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'posCustomerId': posCustomerId,
    };
  }

  factory UserDetailModel.fromMap(Map<String, dynamic> map) {
    return UserDetailModel(
      id: map['_id'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      posCustomerId: map['posCustomerId'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailModel.fromJson(String source) =>
      UserDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
