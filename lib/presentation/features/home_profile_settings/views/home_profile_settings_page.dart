import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yummer/config/app_config.dart';
import 'package:yummer/presentation/core/authentication/bloc/authentication_bloc.dart';
import 'package:yummer/routes/router.gr.dart';

class HomeProfileSettingsPage extends StatelessWidget {
  void onMyWalletClicked(BuildContext context) {
    AutoRouter.of(context).push(MyWalletPageRoute());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppConfig.of(context)!.theme!.primaryColor,
        centerTitle: true,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.end,

            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              InkWell(
                onTap: () {},
                child: Ink(
                  color: Colors.white,
                  height: screenHeight * 0.065,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Setting",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        size: screenWidth * 0.05,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => onMyWalletClicked(context),
                child: Ink(
                  color: Colors.white,
                  height: screenHeight * 0.065,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Wallet",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        size: screenWidth * 0.05,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Ink(
                  color: Colors.white,
                  height: screenHeight * 0.065,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "About",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        size: screenWidth * 0.05,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Ink(
                  color: Colors.white,
                  height: screenHeight * 0.065,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Help",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        size: screenWidth * 0.05,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () => context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested()),
                child: Ink(
                  color: Colors.white,
                  height: screenHeight * 0.065,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Logout",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        size: screenWidth * 0.05,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
