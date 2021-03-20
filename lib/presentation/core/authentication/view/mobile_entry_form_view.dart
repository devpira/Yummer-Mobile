import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:formz/formz.dart';

class MobileEntryFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
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
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  _buildTitle(context, screenWidth, "ENTER YOUR MOBILE NUMBER"),
                  // _buildTitle(context, screenWidth, "MOBILE NUMBER"),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  _PhoneNumberInput(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Text(
                    "By continuing you may receive an SMS for verification. Message and data rates may apply.",
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: AppConfig.of(context).theme.captionTextColor),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  _NextButton(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildTitle(BuildContext context, double width, String title) {
  return SizedBox(
    width: width * 0.8,
    child: Text(
      title,
      style: TextStyle(
        color: AppConfig.of(context).theme.accentColor,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w900,
        fontSize: MediaQuery.of(context).size.height * 0.025,
      ),
    ),
  );
}

class _PhoneNumberInput extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _PhoneNumberInput({
    @required this.screenHeight,
    @required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber ||
          previous.formSubmitted != current.formSubmitted,
      builder: (context, state) {
        print(state.phoneNumber.invalid);
        return TextFieldStyleOne(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onChanged: (String phoneNumber) =>
              context.read<LoginCubit>().phoneNumberChanged(phoneNumber),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          initialValue: state.phoneNumber.value,
          labelText: 'Mobile Number',
          helperText: '',
          errorText: state.formSubmitted && state.phoneNumber.invalid
              ? 'Invalid Mobile Number'
              : null,
        );
      },
    );
  }
}

class _NextButton extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _NextButton({@required this.screenHeight, @required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AccentRaisedButton(
          onClick: () {
            FocusScope.of(context).unfocus();
            context.read<LoginCubit>().startMobileLogin();
          },
          text: "NEXT",
          showProgressBar: state.status.isSubmissionInProgress,
          elevation: 6,
          textStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w800,
          ),
        );
      },
    );
  }
}
