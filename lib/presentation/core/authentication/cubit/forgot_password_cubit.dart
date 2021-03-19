import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:yummer/presentation/core/internet_connectivity/internet_connectivity.dart';


part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthenticationRepository _authenticationRepository;

  final InternetConnectivityCubit _internetConnectivityCubit;
  StreamSubscription _internetConnectivityCubitSubscription;
  bool _hasInternet;

  ForgotPasswordCubit(
    this._authenticationRepository,
    this._internetConnectivityCubit,
  )   : assert(_authenticationRepository != null),
        assert(_internetConnectivityCubit != null),
        super(const ForgotPasswordState()) {
    _hasInternet = _internetConnectivityCubit.state is InternetConnected;
    _internetConnectivityCubitSubscription =
        _internetConnectivityCubit.listen((state) {
      _hasInternet = state is InternetConnected;
    });
  }

  void emailChanged(String value) {
    final email = EmailModel.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email]),
    ));
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      
      if (!_hasInternet) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: "No internet connection."));
        return;
      }

      // Check that email is not empty
      if (state.email.value == null || state.email.value.isEmpty) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: "Please fill in the email address field."));
        return;
      }

      await _authenticationRepository.sentForgotPasswordEmail(
        email: state.email.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(
        state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: e != null && e.toString().isNotEmpty
                ? e.toString()
                : "Failed to send forgot password email. Please try again or contact our support"),
      );
    }
  }

  @override
  Future<void> close() {
    _internetConnectivityCubitSubscription.cancel();
    return super.close();
  }
}
