import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserModel extends Equatable {
  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String photo;

  final bool emailVerifed;

  const UserModel({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo,
    @required this.emailVerifed,
  })  : 
        assert(id != null);

 /// Empty user which represents an unauthenticated user.
  static const empty = UserModel(email: '', id: '', name: null, photo: null, emailVerifed: false);

  @override
  List<Object> get props => [email, id, name, photo, emailVerifed];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'name': name,
      'photo': photo,
      'emailVerifed': emailVerifed,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserModel(
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
