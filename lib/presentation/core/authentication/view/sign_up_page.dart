import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core/internet_connectivity/internet_connectivity.dart';
import 'sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignUpCubit>(
        create: (_) => SignUpCubit(
          getIt<AuthenticationRepository>(),
          getIt<InternetConnectivityCubit>(),
        ),
        child: SignUpForm(),
      ),
    );
  }
}
