import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:yummer/domain/file_storage/file_storage.dart';
import 'package:yummer/domain/user/user_detail.dart';

part 'user_profile_edit_event.dart';
part 'user_profile_edit_state.dart';

@injectable
class UserProfileEditBloc
    extends Bloc<UserProfileEditEvent, UserProfileEditState> {
  final FileStorageRepository _fileStorageRepository;
  final UserDetailRepository _userDetailRepository;

  UserProfileEditBloc({
    required FileStorageRepository fileStorageRepository,
    required UserDetailRepository userDetailRepository,
  })   : _fileStorageRepository = fileStorageRepository,
        _userDetailRepository = userDetailRepository,
        super(const UserProfileEditState());

  @override
  Stream<UserProfileEditState> mapEventToState(
    UserProfileEditEvent event,
  ) async* {
    if (event is UserProfileEditEventInitialize) {
      final email = EmailModel.dirty(event.userDetails.email!);
       final name = NameValueObject.dirty(event.userDetails.name!);
      yield state.copyWith(
          userDetails: event.userDetails,
          user: event.user,
          email: email,
          name: name,
          bio: event.userDetails.bio ?? "",
          status: Formz.validate([name, email]));
    } else if (event is UserProfileEditEventNewImagePicked) {
      print("image selected");
      yield state.copyWith(pickedImageFile: event.pickedImageFile);
    } else if (event is UserProfileEditEventSavedClicked) {
      yield state.copyWith(isSavingInProgress: true);
      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        yield state.copyWith(
          errorMessage:
              "No internet connection. Please double check your connection and try again.",
        );
        return;
      }

      if (!state.status.isValidated ||
          state.name.invalid ||
          state.email.invalid) {
        print("Faield validation");
        emit(state.copyWith(
          formSubmitted: true,
          status: Formz.validate([state.name, state.email]),
        ));
        return;
      }

      final userDetails = state.userDetails!;
      String profileImageUrl = userDetails.profileImageUrl!;
      if (state.pickedImageFile != null) {
        final imageUrl = await _fileStorageRepository.uploadProfileImage(
          file: state.pickedImageFile!,
          userUid: state.user!.id,
        );
        if (imageUrl == null) {
          yield state.copyWith(
            errorMessage:
                "Failed to upload profile image. Try scaling your image down and trying again.",
          );
          return;
        }
        profileImageUrl = imageUrl;

        print(imageUrl);
      }
      print(state.bio);
      final updateResult = await _userDetailRepository.updateUserDetail(
        id: userDetails.id!,
        name: state.name.value,
        email: state.email.value,
        profileImageUrl: profileImageUrl,
        bio: state.bio,
      );

      if (!updateResult) {
        yield state.copyWith(
          errorMessage: "Failed to update your user profile. Please try again.",
        );
        return;
      }
      final updatedUserDetail = userDetails.copyWith(
        name: state.name.value,
        email: state.email.value,
        bio: state.bio,
        profileImageUrl: profileImageUrl,
      );
      yield state.copyWith(
          isSavingCompleted: true, userDetails: updatedUserDetail);
    }
  }

  void nameChanged(String value) {
    final name = NameValueObject.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.email]),
    ));
  }

  void emailChanged(String value) {
    final email = EmailModel.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.name, email]),
    ));
  }

  void bioChanged(String value) {
    emit(state.copyWith(
      bio: value,
    ));
  }
}
