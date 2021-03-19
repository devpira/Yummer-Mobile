import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';


import 'base_form.dart';

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
        }
      },
      child: LayoutBuilder(
        builder: (context, size) {
          final double height = size.maxHeight;
          final double width = size.maxWidth;

          return BaseForm(
            height: height,
            width: width,
            child: Column(
              children: [
                Container(
                  width: width,
                  margin: EdgeInsets.only(top: height * 0.2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(context, width, "Reset"),
                      _buildTitle(context, width, "Password"),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    if (state.status.isSubmissionSuccess) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: height * 0.05, horizontal: width * 0.08),
                        child: const Text(
                          "Forgot password email has been sent. Please check your email inbox.",
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          _EmailInput(),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          _ResetPasswordButton(),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                _GoBackButton(
                  screenHeight: height,
                  screenWidth: width,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildTitle(BuildContext context, double width, String title) {
  return Text(
    title,
    style: TextStyle(
      color: Colors.black,
      fontFamily: 'Quicksand',
      fontWeight: FontWeight.w700,
      fontSize: MediaQuery.of(context).size.width * 0.13,
    ),
  );
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.formSubmitted != current.formSubmitted,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<ForgotPasswordCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: state.formSubmitted && state.email.invalid
                ? 'Please enter a valid email.'
                : null,
          ),
        );
      },
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return PrimaryRaisedButton(
          onClick: () =>
              context.read<ForgotPasswordCubit>().sendPasswordResetEmail(),
          text: "RESET",
          showProgressBar: state.status.isSubmissionInProgress,
          elevation: 0,
          textStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}

class _GoBackButton extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _GoBackButton({
    @required this.screenHeight,
    @required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.06,
      child: RaisedButton(
        key: const Key('loginForm_googleLogin_raisedButton'),
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
        child: const Text(
          'Go Back',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
