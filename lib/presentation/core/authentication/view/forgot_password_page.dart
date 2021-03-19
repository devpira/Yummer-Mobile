import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core/internet_connectivity/internet_connectivity.dart';


import 'forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<ForgotPasswordCubit>(
        create: (_) => ForgotPasswordCubit(
          getIt<AuthenticationRepository>(),
          getIt<InternetConnectivityCubit>(),
        ),
        child: ForgotPasswordForm(),
      ),
    );
  }
}
