import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/routes/router.gr.dart';

import '../home_profile.dart';

class HomeProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final userDetails = context.select((UserDetailBloc bloc) {
      if (bloc.state is UserDetailLoaded) {
        return (bloc.state as UserDetailLoaded).userDetails;
      }
    });
    if (userDetails == null) {
      return Container();
    }
  
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(left: screenWidth * 0.04),
          child: IconButton(
            onPressed: () =>
                AutoRouter.of(context).push(const UserProfileEditPageRoute()),
            icon: const Icon(FontAwesomeIcons.edit),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: screenWidth * 0.04),
            child: TextButton(
              onPressed: () => AutoRouter.of(context)
                  .push(const HomeProfileSettingsPageRoute()),
              child: Text(
                "Settings",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          )
        ],
      ),
      body: HomeProfileBody(userDetails: userDetails),
    );
  }
}
