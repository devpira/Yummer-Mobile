import 'package:flutter/material.dart';
import 'package:yummer/config/app_config.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SplashView();
  }
}

class _SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, // status bar color
        brightness: Brightness.light, // status bar brightness
      ),
      backgroundColor: AppConfig.of(context).theme.primaryColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            // Container(
            //   margin: EdgeInsets.only(
            //       top: MediaQuery.of(context).size.height * 0.2),
            //   child: CircleAvatar(
            //     backgroundColor: Colors.white,
            //     radius: MediaQuery.of(context).size.width * 0.17,
            //     child: Icon(
            //       FontAwesomeIcons.globeAmericas,
            //       color: AppConfig.of(context).theme.primaryColor,
            //       size: MediaQuery.of(context).size.width * 0.2,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.2,
            // ),
            // Shimmer.fromColors(
            //   baseColor: Colors.white,
            //   highlightColor: Colors.cyan[100],
            //   child: Text(
            //     AppConfig.of(context).values.appName,
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontFamily: 'Audiowide',
            //         fontSize: MediaQuery.of(context).size.width * 0.12),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
