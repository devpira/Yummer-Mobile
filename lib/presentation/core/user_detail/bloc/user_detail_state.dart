part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object?> get props => [];
}

class UserDetailNotLoaded extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoadFailed extends UserDetailState {
  final UserModel user;
  final String errorMessage;
  const UserDetailLoadFailed({required this.errorMessage, required this.user});
  @override
  List<Object> get props => [errorMessage, user];
}

class UserDetailNotCreated extends UserDetailState {}

class UserDetailLoadLostInternet extends UserDetailState {
  final UserModel user;

  const UserDetailLoadLostInternet({required this.user});
  @override
  List<Object> get props => [user];
}

class UserDetailLoaded extends UserDetailState {
  final UserModel user;
  final UserDetailModel userDetails;
  final bool? isRefresh;

  const UserDetailLoaded({
    required this.user,
    required this.userDetails,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [user, userDetails, isRefresh];

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'userDetails': userDetails.toMap(),
    };
  }

  factory UserDetailLoaded.fromMap(Map<String, dynamic> map) {
    return UserDetailLoaded(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      userDetails:
          UserDetailModel.fromMap(map['userDetails'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailLoaded.fromJson(String source) =>
      UserDetailLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}
