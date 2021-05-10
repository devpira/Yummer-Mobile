import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:yummer/config/app_config.dart';
import 'package:yummer/domain/user/models/models.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/routes/router.gr.dart';

class HomeProfileBody extends StatelessWidget {
  final UserDetailModel userDetails;
  const HomeProfileBody({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CachedAvatarImage(
              radius: screenHeight * 0.09,
              size: screenHeight * 0.16,
              borderWidth: 3.0,
              showShadow: true,
              imageUrl: userDetails.profileImageUrl != ""
                  ? userDetails.profileImageUrl!
                  : null,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SizedBox(
              width: screenWidth * 0.6,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "@${userDetails.displayName}",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black),
                  textScaleFactor: 1,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            SizedBox(
              width: screenWidth * 0.6,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  userDetails.name!,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                  textScaleFactor: 1,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            SizedBox(
              width: screenWidth * 0.6,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  " Completed 11 Yums",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                      ),
                  textScaleFactor: 1,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => AutoRouter.of(context).push(
                      UserFollowersPageRoute(pageForUid: userDetails.uid!)),
                  child: Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          userDetails.followerCount.toString(),
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                          textScaleFactor: 1,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Followers",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500],
                              ),
                          textScaleFactor: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.08,
                ),
                InkWell(
                  onTap: () => AutoRouter.of(context).push(
                      UserFollowingPageRoute(pageForUid: userDetails.uid!)),
                  child: Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          userDetails.followingCount.toString(),
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                          textScaleFactor: 1,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Following",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500],
                              ),
                          textScaleFactor: 1,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Yum",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025,
                    ),
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(screenWidth * 0.04),
                            topRight: Radius.circular(screenWidth * 0.04),
                            bottomLeft: Radius.circular(screenWidth * 0.04),
                            bottomRight: Radius.circular(screenWidth * 0.04)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              // padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                              margin: EdgeInsets.all(
                                screenHeight * 0.01,
                                // horizontal: screenWidth * 0.06,
                              ),
                              width: screenWidth * 0.2,
                              height: screenWidth * 0.2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(screenWidth * 0.04),
                                      topRight:
                                          Radius.circular(screenWidth * 0.04),
                                      bottomLeft:
                                          Radius.circular(screenWidth * 0.04),
                                      bottomRight:
                                          Radius.circular(screenWidth * 0.04)),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  child: SizedBox(
                                    width: screenWidth * 0.28,
                                    child: Image.network(
                                      "https://theinfluenceagency.com/wp-content/uploads/2020/03/5fe68b9a9897f30893164f41e2baaec7.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.all(screenWidth * 0.03),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FittedBox(
                                      child: Text(
                                        "Yummy Zone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    FittedBox(
                                      child: Text(
                                        "12345 YoMamma House Street, M4J2K3",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.034),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (userDetails.bio != null)
                    Text(
                      userDetails.bio!,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.instagram,
                        color: AppConfig.of(context)!.theme!.primaryColor,
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Text(
                        "PiraTraveller",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
