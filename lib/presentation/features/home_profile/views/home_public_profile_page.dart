import 'package:flutter/material.dart';
import 'package:yummer/domain/user/user_detail.dart';
import 'package:yummer/presentation/core/core.dart';
import '../home_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePublicProfilePage extends StatefulWidget {
  final UserDetailModel userDetails;
  const HomePublicProfilePage({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  _HomePublicProfilePageState createState() => _HomePublicProfilePageState();
}

class _HomePublicProfilePageState extends State<HomePublicProfilePage> {
  late UserDetailModel _userDetails;

  @override
  void initState() {
    super.initState();

    //set the selected to the checked (if not null)
    _userDetails = widget.userDetails;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: screenWidth * 0.04),
            child: TextButton(
              // onPressed: () => AutoRouter.of(context)
              //     .push(const HomeProfileSettingsPageRoute()),
              onPressed: () {
                if (_userDetails.following!) {
                  context.read<UserDetailBloc>().add(
                      UserFollowEventUnFollowUser(
                          unFollowerUid: _userDetails.uid!));
                } else {
                  context.read<UserDetailBloc>().add(UserFollowEventFollowUser(
                      followerUid: _userDetails.uid!));
                }

                setState(() {
                  _userDetails = _userDetails.copyWith(
                      following: !_userDetails.following!);
                });
              },
              child: _userDetails.following != null
                  ? Text(
                      _userDetails.following! ? "Unfollow" : "Follow",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : Container(),
            ),
          )
        ],
      ),
      body: HomeProfileBody(userDetails: _userDetails),
    );
  }
}
