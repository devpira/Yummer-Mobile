import 'dart:convert';

class UserDetailModel {
  String? id;
  String? uid;
  String? phoneNumber;
  String? name;
  String? email;
  String? posCustomerId;
  String? displayName;
  String? profileImageUrl;
  String? bio;
  int? followerCount;
  int? followingCount;
  bool? following;

  UserDetailModel({
    this.id,
    this.uid,
    this.phoneNumber,
    this.name,
    this.email,
    this.posCustomerId,
    this.displayName,
    this.profileImageUrl,
    this.bio,
    this.followerCount,
    this.followingCount,
    this.following,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'posCustomerId': posCustomerId,
      'displayName': displayName,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'followerCount': followerCount,
      'followingCount': followingCount,
      'following': following,
    };
  }

  factory UserDetailModel.fromMap(Map<String, dynamic> map) {
    return UserDetailModel(
      id: map['_id'] as String?,
      uid: map['uid'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      posCustomerId: map['posCustomerId'] as String?,
      displayName: map['displayName'] as String?,
      profileImageUrl: map['profileImageUrl'] as String,
      bio: map['bio'] as String,
      followerCount: map['followerCount'] as int,
      followingCount: map['followingCount'] as int,
      following: map['following']!= null? map['following'] as bool: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailModel.fromJson(String source) =>
      UserDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserDetailModel copyWith({
    String? id,
    String? uid,
    String? phoneNumber,
    String? name,
    String? email,
    String? posCustomerId,
    String? displayName,
    String? profileImageUrl,
    String? bio,
    int? followerCount,
    int? followingCount,
    bool? following,
  }) {
    return UserDetailModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      posCustomerId: posCustomerId ?? this.posCustomerId,
      displayName: displayName ?? this.displayName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      following: following ?? this.following,
    );
  }
}
