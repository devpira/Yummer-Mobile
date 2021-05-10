part of 'user_follow_bloc.dart';

class UserFollowState extends Equatable {
  final List<UserDetailModel>? followersList;
  final List<UserDetailModel>? followingList;

  final bool isFollowersListLoading;
  final bool isFollowingListLoading;

  final String? errorMessage;
  final bool showErrorView;
  final bool showNoInternetView;

  const UserFollowState({
    this.followersList,
    this.followingList,
    this.isFollowersListLoading = false,
    this.isFollowingListLoading = false,
    this.errorMessage,
    this.showErrorView = false,
    this.showNoInternetView = false,
  });

  @override
  List<Object?> get props => [
        followersList,
        followingList,
        isFollowersListLoading,
        isFollowingListLoading,
        errorMessage,
        showErrorView,
        showNoInternetView,
      ];

  UserFollowState copyWith({
    List<UserDetailModel>? followersList,
    List<UserDetailModel>? followingList,
    bool? isFollowersListLoading,
    bool? isFollowingListLoading,
    String? errorMessage,
    bool? showErrorView,
    bool? showNoInternetView,
  }) {
    return UserFollowState(
      followersList: followersList ?? this.followersList,
      followingList: followingList ?? this.followingList,
      isFollowersListLoading: isFollowersListLoading ?? false,
      isFollowingListLoading: isFollowingListLoading ?? false,
      errorMessage: errorMessage,
      showErrorView: showErrorView ?? false,
      showNoInternetView: showNoInternetView ?? false,
    );
  }
}
