part of 'user_profile_edit_bloc.dart';

class UserProfileEditState extends Equatable {
  final File? pickedImageFile;
  final UserModel? user;
  final UserDetailModel? userDetails;

  final NameValueObject name;
  final EmailModel email;
  final String bio;

  final FormzStatus status;
  final String? errorMessage;
  final bool formSubmitted;

  final bool isSavingInProgress;
  final bool isSavingCompleted;

  const UserProfileEditState({
    this.pickedImageFile,
    this.name = const NameValueObject.dirty(),
    this.email = const EmailModel.dirty(),
    this.bio = "",
    this.status = FormzStatus.pure,
    this.formSubmitted = false,
    this.user,
    this.userDetails,
    this.errorMessage,
    this.isSavingInProgress = false,
    this.isSavingCompleted = false,
  });

  @override
  List<Object?> get props {
    return [
      pickedImageFile,
      user,
      userDetails,
      name,
      email,
      bio,
      status,
      errorMessage,
      formSubmitted,
      isSavingInProgress,
      isSavingCompleted,
    ];
  }

  UserProfileEditState copyWith({
    File? pickedImageFile,
    UserModel? user,
    UserDetailModel? userDetails,
    NameValueObject? name,
    EmailModel? email,
    FormzStatus? status,
    String? bio,
    String? errorMessage,
    bool? formSubmitted,
    bool? isSavingInProgress,
    bool? isSavingCompleted,
  }) {
    return UserProfileEditState(
      pickedImageFile: pickedImageFile ?? this.pickedImageFile,
      user: user ?? this.user,
      userDetails: userDetails ?? this.userDetails,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio?? this.bio,
      status: status ?? this.status,
      errorMessage: errorMessage,
      formSubmitted: formSubmitted ?? this.formSubmitted,
      isSavingInProgress: isSavingInProgress ?? false,
      isSavingCompleted: isSavingCompleted ?? false,
    );
  }
}
