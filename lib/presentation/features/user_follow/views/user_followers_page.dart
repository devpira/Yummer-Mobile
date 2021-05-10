import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/features/user_follow/bloc/user_follow_bloc.dart';

class UserFollowersPage extends StatelessWidget {
  final String pageForUid;

  const UserFollowersPage({
    Key? key,
    required this.pageForUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserFollowBloc>(
      create: (_) => getIt<UserFollowBloc>()
        ..add(UserFollowEventLoadMyFollowers(uid: pageForUid)),
      child: _UserFollowingPage(),
    );
  }
}

class _UserFollowingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text("Followers"),
        elevation: 1,
      ),
      body: BlocBuilder<UserFollowBloc, UserFollowState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state.isFollowersListLoading) {
              return LoadingScreen();
            } else if (state.showNoInternetView) {
              return const NoInternetPage();
            } else if (state.showErrorView) {
              return const SystemErrorPage();
            } else if (state.followersList != null) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: state.followersList!
                        .map((item) => UserDetailRowItem(userDetailModel: item))
                        .toList(),
                  ),
                ),
              );
            }
            return LoadingScreen();
          }),
    );
  }
}
