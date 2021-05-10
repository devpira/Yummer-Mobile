import 'package:flutter/material.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/domain/user/user_detail.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';

class UserDetailRowItem extends StatelessWidget {
  final UserDetailModel userDetailModel;
  final Function? onClicked;

  const UserDetailRowItem({
    required this.userDetailModel,
    this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ListTile(
      onTap: () {
        if (onClicked != null) {
          onClicked!();
        }
        AutoRouter.of(context)
            .push(HomePublicProfilePageRoute(userDetails: userDetailModel));
      },
      leading: CachedAvatarImage(
        radius: screenWidth * 0.07,
        imageUrl: userDetailModel.profileImageUrl != ""
            ? userDetailModel.profileImageUrl
            : null,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      title: Text(
        "@${userDetailModel.displayName!}",
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        userDetailModel.name!,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SizedBox(
        width: screenWidth * 0.21,
        height: screenHeight * 0.04,
        child: userDetailModel.following != null? _FollowButton(
          following: userDetailModel.following ?? false,
        ) : Container(),
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final bool following;

  const _FollowButton({
    this.following = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            following? AppConfig.of(context)!.theme!.primaryColor: Colors.white),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          following
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: AppConfig.of(context)!.theme!.primaryColor,
                  ),
                ),
        ),
      ),
      onPressed: null,
      child: FittedBox(
        child: Text(
          following ? "Following" : "Follow",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.caption!.copyWith(
                fontWeight: FontWeight.w700,
                color:following? Colors.white: AppConfig.of(context)!.theme!.primaryColor,
              ),
        ),
      ),
    );
  }
}
