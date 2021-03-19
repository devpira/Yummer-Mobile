part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final EmailModel email;
  final FormzStatus status;
  final String errorMessage;
  final bool formSubmitted;

  const ForgotPasswordState({
    this.email = const EmailModel.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.formSubmitted = false,
  });

  @override
  List<Object> get props => [
        email,
        status,
        errorMessage,
        formSubmitted,
      ];

  ForgotPasswordState copyWith({
    EmailModel email,
    FormzStatus status,
    String errorMessage,
    bool formSubmitted,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      formSubmitted: formSubmitted ?? this.formSubmitted,
    );
  }
}
