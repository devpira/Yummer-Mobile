import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:formz/formz.dart';

class MobileVerifyCodeView extends StatelessWidget {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  BoxDecoration _pinPutDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(color: AppConfig.of(context).theme.primaryColor),
      borderRadius: BorderRadius.circular(15.0),
      color: AppConfig.of(context).theme.textFieldOneBackgroundColor,
    );
  }

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
           // onBackClicked: () => context.read<LoginCubit>().goToMobileEntry(),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.phoneNumber.value !=
                          current.phoneNumber.value,
                      builder: (context, state) {
                        return _buildTitle(context, screenWidth,
                            "ENTER THE 6-DIGIT CODE SENT TO YOU AT ${state.phoneNumber.value}");
                      }),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  PinPut(
                    fieldsCount: 6,
                    autofocus: true,
                    onSubmit: (String pin) {
                      FocusScope.of(context).unfocus();
                      if (pin != null && pin.isNotEmpty) {
                        context.read<LoginCubit>().verifyMobileSMSCode(pin);
                      }
                    },
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration:
                        _pinPutDecoration(context).copyWith(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    selectedFieldDecoration: _pinPutDecoration(context),
                    followingFieldDecoration:
                        _pinPutDecoration(context).copyWith(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: AppConfig.of(context)
                            .theme
                            .accentColor
                            .withOpacity(.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Countdown(
                    seconds: 60,
                    build: (BuildContext context, double time) => Text(
                      "Resend code in: ${time.toStringAsFixed(0).toString()}",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: AppConfig.of(context).theme.captionTextColor),
                    ),
                    interval: const Duration(milliseconds: 100),
                    onFinished: () {
                      print('Timer is done!');
                    },
                  ),
                    SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Didn't receive a verification code?",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppConfig.of(context).theme.captionTextColor),
                  ),
                    Text(
                    "Please wait for time out to resend.",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppConfig.of(context).theme.captionTextColor),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  _NextButton(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    pinPutController: _pinPutController,
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
    width: width * 0.9,
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

class _NextButton extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final TextEditingController pinPutController;

  const _NextButton({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.pinPutController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AccentRaisedButton(
          onClick: () => context
              .read<LoginCubit>()
              .verifyMobileSMSCode(pinPutController.text),
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
