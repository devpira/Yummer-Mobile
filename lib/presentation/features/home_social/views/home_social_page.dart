import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/routes/router.gr.dart';

class HomeSocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Social",
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.03),
              child: _SearchRestuarantInput(
                  screenHeight: screenHeight, screenWidth: screenWidth),
            )
          ],
        ),
      ),
    );
  }
}

class _SearchRestuarantInput extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _SearchRestuarantInput({
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return ButtonTextField(
      screenHeight: screenHeight,
      screenWidth: screenWidth,
      label: "Search User",
      //value: state.destinationString,
      icon: FontAwesomeIcons.search,
      // iconColor: state.selectedDestinations != null &&
      //         state.selectedDestinations!.isNotEmpty
      //     ? AppConfig.of(context)!.theme.primaryColor
      //     : null,
      // errorMessage: state.destinationError,
      onPressed: () async {
        AutoRouter.of(context).push(
          const UserSearchPageRoute(),
        );
        // if (result != null) {
        //   context.read<TripCreationCubit>().onDestinationSaved(
        //       result as List<DestinationSearchResultModel>);
        // }
      },
    );
  }
}
