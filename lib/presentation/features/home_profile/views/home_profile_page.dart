import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/presentation/core/authentication/bloc/authentication_bloc.dart';
import 'package:yummer/presentation/core_widgets/buttons/accent_raised_button.dart';
import 'package:yummer/routes/router.gr.dart';

class HomeProfilePage extends StatelessWidget {
  void onMyWalletClicked(BuildContext context) {
    AutoRouter.of(context).push(MyWalletPageRoute());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AccentRaisedButton(
              onClick: () => onMyWalletClicked(context),
              text: "My Wallet",
            ),
            SizedBox(height: screenHeight * 0.02),
            AccentRaisedButton(
              onClick: () => context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested()),
              text: "Logout",
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
