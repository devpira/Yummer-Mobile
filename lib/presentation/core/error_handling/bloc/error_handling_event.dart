part of 'error_handling_bloc.dart';

abstract class ErrorHandlingEvent extends Equatable {
  const ErrorHandlingEvent();

  @override
  List<Object?> get props => [];
}

class ErrorHandlingShowErrorRequested extends ErrorHandlingEvent {
  final String? errorMessage;
  final Function? tryAgainFunction;

  const ErrorHandlingShowErrorRequested({this.errorMessage, this.tryAgainFunction});

  @override
  List<Object?> get props => [errorMessage, tryAgainFunction];
}
