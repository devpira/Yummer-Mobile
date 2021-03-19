import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'base_form.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
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
                  margin: EdgeInsets.only(top: height * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(context, width, "Sign Up"),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                _EmailInput(),
                _PasswordInput(),
                _ConfirmPasswordInput(),
                SizedBox(
                  height: height * 0.04,
                ),
                _SignUpButton(),
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
      fontWeight: FontWeight.w500,
      fontSize: MediaQuery.of(context).size.width * 0.11,
    ),
  );
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.formSubmitted != current.formSubmitted,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
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

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.formSubmitted != current.formSubmitted ||
          previous.showPassword != current.showPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: !state.showPassword,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              icon: const Icon(Icons.visibility),
              color: state.showPassword
                  ? AppConfig.of(context).theme.primaryColor
                  : Colors.black45,
              onPressed: () => context.read<SignUpCubit>().toggleShowPassword(),
            ),
            helperText: 'Atleast 8 letters with a number and upper case',
            errorText: state.formSubmitted && state.password.invalid
                ? 'Atleast 8 chars with a number and upper case'
                : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword ||
          previous.formSubmitted != current.formSubmitted ||
          previous.showPassword != current.showPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: !state.showPassword,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            helperText: '',
            errorText: state.formSubmitted && state.confirmedPassword.invalid
                ? 'Passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AccentRaisedButton(
          onClick: () => context.read<SignUpCubit>().signUpFormSubmitted(),
          text: "SIGN UP",
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

  const _GoBackButton(
      {@required this.screenHeight, @required this.screenWidth});

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
