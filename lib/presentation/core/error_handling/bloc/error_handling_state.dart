part of 'error_handling_bloc.dart';

abstract class ErrorHandlingState extends Equatable {
  const ErrorHandlingState();

  @override
  List<Object> get props => [];
}

class ErrorHandlingInitial extends ErrorHandlingState {}

class ErrorHandlingNewErrorOccurred extends ErrorHandlingState {
  final String errorMessage;
  final Function tryAgainFunction;

  const ErrorHandlingNewErrorOccurred(
      {this.errorMessage, this.tryAgainFunction});

  @override
  List<Object> get props => [errorMessage, tryAgainFunction];
}
