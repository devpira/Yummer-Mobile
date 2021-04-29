import 'dart:convert';

import 'package:equatable/equatable.dart';


class UserModel extends Equatable {
  /// The current user's email address.
  final String email;

  final String phoneNumber;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String photo;

  final bool emailVerifed;

  const UserModel({
    required this.phoneNumber,
    required this.email,
    required this.id,
    required this.name,
    required this.photo,
    required this.emailVerifed,
  })  : assert(phoneNumber != null),
        assert(id != null);

 /// Empty user which represents an unauthenticated user.
  static const empty = UserModel(phoneNumber: '', email: '', id: '', name: null, photo: null, emailVerifed: false);

  @override
  List<Object> get props => [email, id, name, photo, emailVerifed];

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'email': email,
      'id': id,
      'name': name,
      'photo': photo,
      'emailVerifed': emailVerifed,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {

  
    return UserModel(
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      id: map['id'],
      name: map['name'],
      photo: map['photo'],
      emailVerifed: map['emailVerifed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
