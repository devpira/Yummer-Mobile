part of 'create_user_detail_cubit.dart';

class CreateUserDetailState extends Equatable {
  final NameValueObject name;
  final EmailModel email;

  final FormzStatus status;
  final String errorMessage;
  final bool formSubmitted;

  const CreateUserDetailState({
    this.name = const NameValueObject.dirty(),
    this.email = const EmailModel.dirty(),
    this.status = FormzStatus.pure,
    this.formSubmitted = false,
    this.errorMessage,
  });

  @override
  List<Object> get props {
    return [
      name,
      email,
      status,
      errorMessage,
      formSubmitted,
    ];
  }

  CreateUserDetailState copyWith({
    NameValueObject name,
    EmailModel email,
    FormzStatus status,
    String errorMessage,
    bool formSubmitted,
  }) {
    return CreateUserDetailState(
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      formSubmitted: formSubmitted ?? this.formSubmitted,
    );
  }
}
