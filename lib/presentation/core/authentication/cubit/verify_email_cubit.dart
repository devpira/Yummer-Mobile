import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:yummer/presentation/core/internet_connectivity/internet_connectivity.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final AuthenticationRepository _authenticationRepository;

  final InternetConnectivityCubit _internetConnectivityCubit;
  StreamSubscription _internetConnectivityCubitSubscription;
  bool _hasInternet;

  VerifyEmailCubit(
    this._authenticationRepository,
    this._internetConnectivityCubit,
  )   : assert(_authenticationRepository != null),
        assert(_internetConnectivityCubit != null),
        super(VerifyEmailInitial()) {
    _hasInternet = _internetConnectivityCubit.state is InternetConnected;
    _internetConnectivityCubitSubscription =
        _internetConnectivityCubit.listen((state) {
      _hasInternet = state is InternetConnected;
    });
  }

  Future<void> resendEmailVerification() async {
    try {
      if (!_hasInternet) {
        emit(const VerifyEmailFailure(errorMessage: "No internet connction."));
        return;
      }
      emit(ResendingVerifyEmailInProgress());
      await _authenticationRepository.resendEmailVerification();
      emit(ResendingVerifyEmailCompleted());
    } catch (e) {
      emit(
        VerifyEmailFailure(
            errorMessage: e != null && e.toString().isNotEmpty
                ? e.toString()
                : "Failed to resend email verficaiton. Please try again or contact our support"),
      );
    }
  }

  void emitVerifyEmailFailure(String errorMessage) {
    emit(VerifyEmailFailure(errorMessage: errorMessage));
  }

  @override
  Future<void> close() {
    _internetConnectivityCubitSubscription.cancel();
    return super.close();
  }
}
