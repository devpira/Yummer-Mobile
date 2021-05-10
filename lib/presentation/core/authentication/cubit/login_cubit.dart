import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:yummer/presentation/core/internet_connectivity/internet_connectivity.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final InternetConnectivityCubit _internetConnectivityCubit;
  late StreamSubscription _internetConnectivityCubitSubscription;
  late bool _hasInternet;

  LoginCubit(
    this._authenticationRepository,
    this._internetConnectivityCubit,
  )   : assert(_authenticationRepository != null),
        assert(_internetConnectivityCubit != null),
        super(LoginState(currentPage: LoginInitalPageState())) {
    _hasInternet = _internetConnectivityCubit.state is InternetConnected;
    _internetConnectivityCubitSubscription =
        _internetConnectivityCubit.listen((state) {
      _hasInternet = state is InternetConnected;
    });
  }

  void goToMobileEntry() {
    emit(state.copyWith(
      currentPage: LoginMobileEntryPageState(),
    ));
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumberValueObject.dirty(value);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([phoneNumber]),
    ));
  }

  Future<void> startMobileLogin() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      if (!state.status.isValidated || state.phoneNumber.invalid) {
        emit(state.copyWith(
          formSubmitted: true,
          status: Formz.validate([state.phoneNumber]),
        ));
        return;
      }
      print("STARTING AUTH");
      await _authenticationRepository.loginWithPhone(
        phoneNumber: "+1${state.phoneNumber.value}",
        onVerificationCompleted: () {
          emit(state.copyWith(
              currentPage: LoginMobileNumberVerifyPageState(),
              status: FormzStatus.submissionSuccess));
        },
        onCodeSent: (String verificationId, int resendToken) {
          emit(state.copyWith(
              phoneVerificationId: verificationId,
              phoneResendToken: resendToken,
              currentPage: LoginMobileNumberVerifyPageState(),
              status: FormzStatus.submissionSuccess));
        },
        onVerificationFailed: (String value) => {
          emit(state.copyWith(
              status: FormzStatus.submissionFailure, errorMessage: value))
        },
        codeAutoRetrievalTimeout: () => {
            emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              errorMessage: "SMS Verification timed out. Please try again.",
             currentPage: LoginMobileEntryPageState(),
          ),),
        }
      );

      // emit(state.copyWith(
      //     currentPage: LoginMobileNumberVerifyPageState(),
      //     status: FormzStatus.submissionSuccess));
      //emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage:
              "Unexpected error occurred. Please try again or contact our support team."));
    }
  }

  Future<void> verifyMobileSMSCode(String smsCode) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    print(smsCode);
    print(state.phoneVerificationId);
    try {
      if (smsCode == null || smsCode.isEmpty) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: "Please enter your SMS verification code"));
        return;
      }

      if (smsCode.length < 6) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: "Invalid SMS verification code"));
        return;
      }
      print("STARTING AUTH");
      await _authenticationRepository.logInWithSMSCredential(
        verificationId: state.phoneVerificationId!,
        smsCode: smsCode,
      );
      print("SUCCESS");
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      //emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e != null && e.toString().isNotEmpty
              ? e.toString()
              : "Failed to validate SMS Code. Please try again."));
    }
  }

  /// following is old code:

  void emailChanged(String value) {
    final email = EmailModel.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = PasswordModel.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  void toggleShowPassword() {
    emit(state.copyWith(
      showPassword: !state.showPassword,
    ));
  }

  Future<void> logInWithCredentials() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    // Check internet connectivity:
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
          errorMessage: "Please enter your email address."));
      return;
    }
    // Check that password is not empty
    if (state.password.value == null || state.password.value.isEmpty) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: "Please enter your password."));
      return;
    }

    if (!state.status.isValidated) {
      emit(state.copyWith(
        formSubmitted: true,
        status: Formz.validate([state.email, state.password]),
      ));
      return;
    }

    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e != null && e.toString().isNotEmpty
              ? e.toString()
              : "Login failed. Please try again."));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage:
              "Unexpected error occurred. Please try again or contact our support team."));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }

  @override
  Future<void> close() {
    _internetConnectivityCubitSubscription.cancel();
    return super.close();
  }
}
