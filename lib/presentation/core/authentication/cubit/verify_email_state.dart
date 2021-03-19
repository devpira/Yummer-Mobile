part of 'verify_email_cubit.dart';

abstract class VerifyEmailState extends Equatable {
  const VerifyEmailState();

  @override
  List<Object> get props => [];
}

class VerifyEmailInitial extends VerifyEmailState {}

class ResendingVerifyEmailInProgress extends VerifyEmailState {}

class ResendingVerifyEmailCompleted extends VerifyEmailState {}

class VerifyEmailFailure extends VerifyEmailState {
  final String errorMessage;

  const VerifyEmailFailure({
    @required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

