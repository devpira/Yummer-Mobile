part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  final EmailModel email;
  final PasswordModel password;
  final ConfirmedPasswordModel confirmedPassword;
  final FormzStatus status;
  final String errorMessage;
  final bool formSubmitted;
  final bool showPassword;

  const SignUpState({
    this.email = const EmailModel.pure(),
    this.password = const PasswordModel.pure(),
    this.confirmedPassword = const ConfirmedPasswordModel.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.formSubmitted = false,
    this.showPassword = false,
  });

  @override
  List<Object> get props => [
        email,
        password,
        confirmedPassword,
        status,
        errorMessage,
        formSubmitted,
        showPassword
      ];

  SignUpState copyWith({
    EmailModel email,
    PasswordModel password,
    ConfirmedPasswordModel confirmedPassword,
    FormzStatus status,
    String errorMessage,
    bool formSubmitted,
    bool showPassword,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      formSubmitted: formSubmitted ?? this.formSubmitted,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}
