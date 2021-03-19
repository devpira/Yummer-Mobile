import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:yummer/presentation/core/internet_connectivity/internet_connectivity.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepository _authenticationRepository;
  final InternetConnectivityCubit _internetConnectivityCubit;
  StreamSubscription _internetConnectivityCubitSubscription;
  bool _hasInternet;

  SignUpCubit(
    this._authenticationRepository,
    this._internetConnectivityCubit,
  )   : assert(_authenticationRepository != null),
        assert(_internetConnectivityCubit != null),
        super(const SignUpState()) {
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
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void toggleShowPassword() {
    emit(state.copyWith(
      showPassword: !state.showPassword,
    ));
  }

  void passwordChanged(String value) {
    final password = PasswordModel.dirty(value);
    final confirmedPassword = ConfirmedPasswordModel.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        password,
        state.confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPasswordModel.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
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
    // Check that password is not empty
    if (state.password.value == null || state.password.value.isEmpty) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: "Please fill in the password field."));
      return;
    }

    // Check that password is not empty
    if (state.confirmedPassword.value == null ||
        state.confirmedPassword.value.isEmpty) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: "Please confirm your password."));
      return;
    }

    if (!state.status.isValidated) {
      emit(
        state.copyWith(
          formSubmitted: true,
          status: Formz.validate(
              [state.email, state.password, state.confirmedPassword]),
        ),
      );
      return;
    }

    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(
        state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: e != null && e.toString().isNotEmpty
                ? e.toString()
                : "Sign up failed. Please try again."),
      );
    }
  }

  @override
  Future<void> close() {
    _internetConnectivityCubitSubscription.cancel();
    return super.close();
  }
}
