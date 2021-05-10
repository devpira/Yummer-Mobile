part of 'create_user_detail_cubit.dart';

class CreateUserDetailState extends Equatable {
  final DisplayNameValueObject displayName;
  final NameValueObject name;
  final EmailModel email;

  final FormzStatus status;
  final String? errorMessage;
  final bool formSubmitted;

  const CreateUserDetailState({
    this.displayName = const DisplayNameValueObject.dirty(),
    this.name = const NameValueObject.dirty(),
    this.email = const EmailModel.dirty(),
    this.status = FormzStatus.pure,
    this.formSubmitted = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props {
    return [
      displayName,
      name,
      email,
      status,
      errorMessage,
      formSubmitted,
    ];
  }

  CreateUserDetailState copyWith({
    DisplayNameValueObject? displayName,
    NameValueObject? name,
    EmailModel? email,
    FormzStatus? status,
    String? errorMessage,
    bool? formSubmitted,
  }) {
    return CreateUserDetailState(
      displayName: displayName ?? this.displayName,
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      formSubmitted: formSubmitted ?? this.formSubmitted,
    );
  }
}
