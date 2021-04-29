import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';

class NoInternetPage extends StatelessWidget {
  final Function? tryAgainFunction;
  final bool showLogOut;

  const NoInternetPage({
    Key? key,
    this.tryAgainFunction,
    this.showLogOut = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   height: screenHeight * 0.3,
            //   width: screenWidth * 0.35,
            //   child: Image.asset('assets/images/error_face.png'),
            // ),
            Text(
              "No internet connection!",
              style: TextStyle(
                  fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Container(
              margin: EdgeInsets.only(right: screenWidth * 0.1),
              child: const Text(
                "Please double check your connection and try again.",
                //textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: screenHeight * 0.07),
            if (tryAgainFunction != null)
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.06,
                child: PrimaryRaisedButton(
                  onClick: tryAgainFunction,
                  text: "TRY AGAIN",
                  elevation: 0,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (showLogOut)
              SizedBox(
                height: screenHeight * 0.05,
              ),
            if (showLogOut)
              Align(
                child: InkWell(
                  onTap: () => context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested()),
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.035,
                      fontFamily: 'Quicksand',
                      color: AppConfig.of(context)!.theme!.primaryColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ));
  }
}
