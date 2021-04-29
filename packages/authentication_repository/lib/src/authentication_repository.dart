import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'models/models.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {
  final String errorCode;
  final String errorMessage;
  const SignUpFailure({this.errorCode = "", this.errorMessage = ""});

  @override
  String toString() {
    return errorMessage;
  }
}

class SendForgotPasswordEmailFailure implements Exception {
  final String errorCode;
  final String errorMessage;
  const SendForgotPasswordEmailFailure({
    this.errorCode = "",
    this.errorMessage = "",
  });

  @override
  String toString() {
    return errorMessage;
  }
}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {
  final String errorCode;
  final String errorMessage;
  const LogInWithEmailAndPasswordFailure({
    this.errorCode = "",
    this.errorMessage = "",
  });

  @override
  String toString() {
    return errorMessage;
  }
}

class LogInWithPhoneFailure implements Exception {
  final String errorCode;
  final String errorMessage;
  const LogInWithPhoneFailure({
    this.errorCode = "",
    this.errorMessage = "",
  });

  @override
  String toString() {
    return errorMessage;
  }
}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

/// Thrown during the resending of the email verfication email process if a failure occurs.
class ResendEmailVerificationFailure implements Exception {
  final String errorCode;
  final String errorMessage;
  const ResendEmailVerificationFailure({
    this.errorCode = "",
    this.errorMessage = "",
  });

  @override
  String toString() {
    return errorMessage;
  }
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// Thrown during the initializing verify email dynamic link  if a failure occurs.
class InitVerifyEmailDynamicLinksFailure implements Exception {}

class SendVerifyEmailConfig {
  final String url;
  final String androidPackageName;
  final bool handleCodeInApp;
  final String dynamicLinkDomain;
  final bool androidInstallApp;
  final String androidMinimumVersion;
  final String? iOSBundleId;

  SendVerifyEmailConfig({
    required this.url,
    required this.androidPackageName,
    this.handleCodeInApp = true,
    this.dynamicLinkDomain = "",
    this.androidInstallApp = true,
    this.androidMinimumVersion = "12",
    this.iOSBundleId,
  });
}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final SendVerifyEmailConfig? sendVerifyEmailConfig;

  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    this.sendVerifyEmailConfig,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    firebase_auth.UserCredential userCredential;
    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      switch (e.code) {
        case 'email-already-in-use':
        case 'auth/email-already-in-use':
        case 'account-exists-with-different-credential':
          throw SignUpFailure(
              errorCode: e.code,
              errorMessage:
                  "The email you entered already exists. Please enter another one.");
          break;
        case 'invalid-email':
        case 'auth/invalid-email':
          throw SignUpFailure(
              errorCode: e.code,
              errorMessage:
                  "The email you have entered is invalid. Please try again.");
          break;
        case 'weak-password':
        case 'auth/weak-password':
          throw SignUpFailure(
              errorCode: e.code,
              errorMessage:
                  "The password you have entered is not acceptable. Please try again.");
          break;
        default:
          throw SignUpFailure(
              errorCode: e.code,
              errorMessage:
                  "Failed to sign up. Please try again or contact our support for help.");
      }
    }

    try {
      if (userCredential == null || userCredential.user == null) {
        throw new Exception();
      }

      if (sendVerifyEmailConfig != null) {
        var actionCodeSettings = ActionCodeSettings(
          url:
              '${sendVerifyEmailConfig?.url}?email=${userCredential.user?.email}',
          handleCodeInApp: sendVerifyEmailConfig?.handleCodeInApp,
          dynamicLinkDomain: sendVerifyEmailConfig?.dynamicLinkDomain,
          androidInstallApp: sendVerifyEmailConfig?.androidInstallApp,
          androidPackageName: sendVerifyEmailConfig?.androidPackageName,
          androidMinimumVersion: sendVerifyEmailConfig?.androidMinimumVersion,
          iOSBundleId: sendVerifyEmailConfig?.iOSBundleId,
        );
        await userCredential.user?.sendEmailVerification(actionCodeSettings);
      } else {
        await userCredential.user?.sendEmailVerification();
      }
    } catch (e) {
      print(e);
      // We don't throw exception again because if sending email failed, user will be able to retry.
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  Future<void> sentForgotPasswordEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'too-many-requests':
        case 'auth/too-many-requests':
          throw SendForgotPasswordEmailFailure(
              errorCode: e.code,
              errorMessage: "Please wait a moment before trying again.");
          break;
        case 'invalid-email':
        case 'auth/invalid-email':
          throw SendForgotPasswordEmailFailure(
              errorCode: e.code,
              errorMessage:
                  "The email you have entered is invalid. Please try again.");
          break;
        case 'user-not-found':
        case 'auth/user-not-found':
          throw SendForgotPasswordEmailFailure(
              errorCode: e.code,
              errorMessage:
                  "The email you have entered does not exist. Please try again.");
          break;
        default:
          throw SendForgotPasswordEmailFailure(
              errorCode: e.code,
              errorMessage:
                  "Unexpect error occurred. Please try again or contact our support for help.");
      }
    }
  }

  Future<void> resendEmailVerification() async {
    try {
      final user = firebase_auth.FirebaseAuth.instance.currentUser;

      if (sendVerifyEmailConfig != null) {
        var actionCodeSettings = ActionCodeSettings(
          url: '${sendVerifyEmailConfig?.url}?email=${user?.email}',
          handleCodeInApp: sendVerifyEmailConfig?.handleCodeInApp,
          dynamicLinkDomain: sendVerifyEmailConfig?.dynamicLinkDomain,
          androidInstallApp: sendVerifyEmailConfig?.androidInstallApp,
          androidPackageName: sendVerifyEmailConfig?.androidPackageName,
          androidMinimumVersion: sendVerifyEmailConfig?.androidMinimumVersion,
          iOSBundleId: sendVerifyEmailConfig?.iOSBundleId,
        );
        await user?.sendEmailVerification(actionCodeSettings);
      } else {
        await user?.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      switch (e.code) {
        case 'too-many-requests':
        case 'auth/too-many-requests':
          throw ResendEmailVerificationFailure(
              errorCode: e.code,
              errorMessage: "Please wait a moment before trying again.");
          break;
        default:
          throw ResendEmailVerificationFailure(
              errorCode: e.code,
              errorMessage:
                  "Unexpect error occurred. Please try again or contact our support for help.");
      }
    }
  }

  Future<void> initVerifyEmailDynamicLinks(
      {required Function onSuccess, required Function onError}) async {
    try {
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        if (dynamicLink != null) {
          final Uri deepLink = dynamicLink.link;
          print("YOOO");
          if (deepLink != null) {
            print("YOOO2");
            await firebase_auth.FirebaseAuth.instance.currentUser?.reload();
            onSuccess(firebase_auth.FirebaseAuth.instance.currentUser?.toUser);
            return;
          }
        }
      }, onError: (OnLinkErrorException e) async {
        print(e.message);
        onError(e);
      });

      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (data != null) {
        final Uri deepLink = data.link;

        if (deepLink != null) {
          await firebase_auth.FirebaseAuth.instance.currentUser?.reload();
          onSuccess(firebase_auth.FirebaseAuth.instance.currentUser?.toUser);
        }
      }
    } on FirebaseAuthException  catch (e) {
      print(e.message);
      onError(e);
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException  catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'auth/user-not-found':
          throw LogInWithEmailAndPasswordFailure(
              errorCode: e.code,
              errorMessage:
                  "The email you entered does not exist. Please try again.");
          break;
        case 'wrong-password':
        case 'auth/wrong-password':
          throw LogInWithEmailAndPasswordFailure(
              errorCode: e.code,
              errorMessage: "Incorrect password. Please try again.");
          break;
        case 'user-disabled':
        case 'auth/user-disabled':
          throw LogInWithEmailAndPasswordFailure(
              errorCode: e.code,
              errorMessage:
                  "This account has been disabled. Please contact our support for help.");
          break;
        case 'ERROR_WEAK_PASSWORD':
          throw LogInWithEmailAndPasswordFailure(
              errorCode: e.code,
              errorMessage: "Please enter a stronger password");
          break;
        case 'invalid-email':
        case 'auth/invalid-email':
        case 'ERROR_INVALID_EMAIL':
          throw LogInWithEmailAndPasswordFailure(
              errorCode: e.code,
              errorMessage:
                  "The email you have entered is invalid. Please try again.");
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          throw LogInWithEmailAndPasswordFailure(
              errorCode: e.code,
              errorMessage: "The email already exists. Please try another.");
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED':
          throw LogInWithEmailAndPasswordFailure(
              errorCode: e.code,
              errorMessage:
                  "No internet connection found. Please check your network settings and try again.");
          break;
        default:
          throw LogInWithEmailAndPasswordFailure(
              errorCode: e.code,
              errorMessage: "Failed to login. Please try again.");
      }
    }
  }

  Future<void> loginWithPhone({
    required String phoneNumber,
    required Function onCodeSent,
    required Function onVerificationCompleted,
    required Function onVerificationFailed,
    required Function codeAutoRetrievalTimeout,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) async {
        print("COMING IN COMPLETED");
        _firebaseAuth.signInWithCredential(phoneAuthCredential);
        onVerificationCompleted();
      },
      verificationFailed: (FirebaseAuthException e) async {
        print(e);
        String errorMessage =
            "Failed to verify phone number. Please try again later";
        if (e.code == 'invalid-phone-number') {
          errorMessage = 'The provided phone number is not valid.';
        }
        onVerificationFailed(errorMessage);
      },
      codeSent: (String verificationId, int resendToken) async {
        onCodeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
        codeAutoRetrievalTimeout();
        // onVerificationFailed("Phone verification timed out. Please try again in one minute.");
      },
    );
  }

  Future<void> logInWithSMSCredential({
    required String verificationId,
    required String smsCode,
  }) async {
    assert(smsCode != null && verificationId != null);
    try {
      await _firebaseAuth.signInWithCredential(
        firebase_auth.PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        ),
      );
    }  on FirebaseAuthException  catch (e) {
      print(e);
      switch (e.code) {
        case 'firebase_auth/invalid-verification-code':
          throw LogInWithPhoneFailure(
              errorCode: e.code,
              errorMessage: "Invalid SMS Code. Please try again.");
          break;
        default:
          throw LogInWithEmailAndPasswordFailure(
              errorCode: e.code,
              errorMessage: "Invalid SMS Code. Please try again.");
      }
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(
      id: uid,
      phoneNumber: phoneNumber,
      email: email,
      name: displayName,
      photo: photoURL,
      emailVerifed: emailVerified,
    );
  }
}
