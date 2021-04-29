import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core/authentication/view/get_started_view.dart';
import 'package:yummer/presentation/core/authentication/view/mobile_entry_form_view.dart';
import 'package:yummer/presentation/core/authentication/view/mobile_verify_code_view.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
        }
      },
      buildWhen: (previous, current) =>
          previous.currentPage != current.currentPage,
      builder: (context, state) {
        if (state.currentPage is LoginInitalPageState) {
          return GetStartedView();
        } else if (state.currentPage is LoginMobileEntryPageState) {
          return MobileEntryFormView();
        } else if (state.currentPage is LoginMobileNumberVerifyPageState) {
          return MobileVerifyCodeView();
        }
        return Container();
      },
    );
  }
}
