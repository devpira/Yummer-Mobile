import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'error_handling_event.dart';
part 'error_handling_state.dart';

@lazySingleton
class ErrorHandlingBloc extends Bloc<ErrorHandlingEvent, ErrorHandlingState> {
  ErrorHandlingBloc() : super(ErrorHandlingInitial());

  @override
  Stream<ErrorHandlingState> mapEventToState(
    ErrorHandlingEvent event,
  ) async* {
    if (event is ErrorHandlingShowErrorRequested) {
      yield _mapErrorHandlingShowErrorRequestedToState(event);
    }
  }

  void emitSystemError({String errorMessage, Function tryAgainFunction}){
    add(ErrorHandlingShowErrorRequested(errorMessage: errorMessage, tryAgainFunction: tryAgainFunction));
  }

  ErrorHandlingState _mapErrorHandlingShowErrorRequestedToState(
      ErrorHandlingShowErrorRequested event) {
    return ErrorHandlingNewErrorOccurred(
        errorMessage: event.errorMessage,
        tryAgainFunction: event.tryAgainFunction);
  }
}
