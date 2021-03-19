part of 'login_cubit.dart';

class LoginState extends Equatable {
  final LoginPageState currentPage;
  final PhoneNumberValueObject phoneNumber;
  final String phoneVerificationId;
  final int phoneResendToken;

  final EmailModel email;
  final PasswordModel password;
  final FormzStatus status;
  final String errorMessage;
  final bool formSubmitted;
  final bool showPassword;

  const LoginState({
    this.currentPage,
    this.phoneNumber = const PhoneNumberValueObject.dirty(),
    this.phoneVerificationId,
    this.phoneResendToken,
    this.email = const EmailModel.pure(),
    this.password = const PasswordModel.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.formSubmitted = false,
    this.showPassword = false,
  });

  @override
  List<Object> get props => [
        currentPage,
        phoneNumber,
        phoneVerificationId,
        phoneResendToken,
        email,
        password,
        status,
        errorMessage,
        formSubmitted,
        showPassword
      ];

  LoginState copyWith({
    LoginPageState currentPage,
    PhoneNumberValueObject phoneNumber,
    String phoneVerificationId,
    int phoneResendToken,
    EmailModel email,
    PasswordModel password,
    FormzStatus status,
    String errorMessage,
    bool formSubmitted,
    bool showPassword,
  }) {
    return LoginState(
      currentPage: currentPage ?? this.currentPage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneVerificationId: phoneVerificationId ?? this.phoneVerificationId,
      phoneResendToken: phoneResendToken ?? this.phoneResendToken,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      formSubmitted: formSubmitted ?? this.formSubmitted,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

abstract class LoginPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitalPageState extends LoginPageState {}

class LoginMobileEntryPageState extends LoginPageState {}

class LoginMobileNumberVerifyPageState extends LoginPageState {}
