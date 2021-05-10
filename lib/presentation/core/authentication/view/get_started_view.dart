import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core_widgets/buttons/accent_raised_button.dart';

class GetStartedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppConfig.of(context)!.theme!.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Center(
              child: Image.asset(
                "assets/images/get_started_name.png",
              ),
            ),
          ),
          SizedBox(
            // margin: EdgeInsets.only(bottom: screenHeight * 0.03),
            //width: width * 0.6,
            child: Center(
              child: Image.asset(
                "assets/images/login_page_img.png",
                // width: width * 0.6,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.08,),
          _GetStartedButton(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
          )
        ],
      ),
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _GetStartedButton(
      {required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: AccentRaisedButton(
            onClick: () => context.read<LoginCubit>().goToMobileEntry(),
            text: "GET STARTED",
            // showProgressBar: state.status.isSubmissionInProgress,
            elevation: 6,
            textStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w800,
            ),
          ),
        );
      },
    );
  }
}
