import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yummer/config/config.dart';
import 'package:yummer/domain/user/user_detail.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/feature.dart';

class UserProfileEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDetails = context.select(
        (UserDetailBloc bloc) => (bloc.state as UserDetailLoaded).userDetails);
    final user = context
        .select((UserDetailBloc bloc) => (bloc.state as UserDetailLoaded).user);

    return BlocProvider(
      create: (_) => getIt<UserProfileEditBloc>()
        ..add(UserProfileEditEventInitialize(
          userDetails: userDetails,
          user: user,
        )),
      child: _UserProfileEditPage(userDetails: userDetails),
    );
  }
}

class _UserProfileEditPage extends StatelessWidget {
  final UserDetailModel userDetails;

  const _UserProfileEditPage({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  Future<void> _cropImage(BuildContext context, File imageFile) async {
    final File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        cropStyle: CropStyle.circle,
        // maxHeight: 400,
        //  maxWidth: 400,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.original,
              ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Adjust Image',
          toolbarColor: AppConfig.of(context)!.theme!.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          statusBarColor: AppConfig.of(context)!.theme!.primaryColor,
          activeControlsWidgetColor: AppConfig.of(context)!.theme!.primaryColor,
        ),
        iosUiSettings: const IOSUiSettings(
          title: 'Adjust Image',
        ));

    if (croppedFile != null) {
      context.read<UserProfileEditBloc>().add(
          UserProfileEditEventNewImagePicked(pickedImageFile: croppedFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
     // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //     icon: const Icon(FontAwesomeIcons.solidTimesCircle),
        //     onPressed: () => context.router.pop()),
        title: Text(
          "Edit Profile",
          style: TextStyle(
              fontSize: screenWidth * 0.05, fontWeight: FontWeight.w700),
        ),
        actions: [
          BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.only(right: screenWidth * 0.03),
                child: TextButton(
                  onPressed: state.isSavingInProgress
                      ? () {}
                      : () {
                          context
                              .read<UserProfileEditBloc>()
                              .add(UserProfileEditEventSavedClicked());
                        },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<UserProfileEditBloc, UserProfileEditState>(
          listener: (context, state) {
        // if (state.isSavingInProgress) {
        //   AutoRouter.of(context).push(const LoadingScreenRoute());
        // }

        if (state.errorMessage != null) {
          //  AutoRouter.of(context).pop();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
              ),
            );
        }
        if (state.isSavingCompleted) {
          // AutoRouter.of(context).pop();
          AutoRouter.of(context).pop();
          context.read<UserDetailBloc>().add(
              UserDetailEventUpdateUserDetailsState(
                  userDetailModel: state.userDetails!));
        }
      }, builder: (context, state) {
        if (state.isSavingInProgress) {
          return LoadingScreen();
        }
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.03),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: const Offset(
                                  0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            BlocBuilder<UserProfileEditBloc,
                                UserProfileEditState>(
                              buildWhen: (previous, current) =>
                                  previous.pickedImageFile !=
                                  current.pickedImageFile,
                              builder: (context, state) {
                                if (state.pickedImageFile == null) {
                                  return CachedAvatarImage(
                                    radius: screenHeight * 0.08,
                                    backgroundColor: Colors.blueGrey,
                                    imageUrl: userDetails.profileImageUrl != ""
                                        ? userDetails.profileImageUrl!
                                        : null,
                                  );
                                } else {
                                  return Container(
                                    height: screenHeight * 0.16,
                                    width: screenHeight * 0.16,
                                    decoration: const BoxDecoration(
                                      color: Colors.black26,
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: Image.file(
                                        state.pickedImageFile!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            Container(
                              padding: EdgeInsets.all(screenHeight * 0.0035),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Container(
                                padding: EdgeInsets.all(screenHeight * 0.01),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[500]),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: screenHeight * 0.02,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    customBorder: const CircleBorder(),
                                    onTap: () async {
                                      final file = await ImagePicker().getImage(
                                          source: ImageSource.gallery);
                                      if (file != null)
                                        _cropImage(context, File(file.path));
                                    }

                                    // context.read<UserProfileEditBloc>().add(UserProfileEditEventPickNewImage()),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
                    buildWhen: (previous, current) =>
                        previous.name != current.name ||
                        previous.formSubmitted != current.formSubmitted,
                    builder: (context, state) {
                      return TextFieldStyleOne(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        onChanged: (String name) => context
                            .read<UserProfileEditBloc>()
                            .nameChanged(name),
                        textInputAction: TextInputAction.next,
                        initialValue: userDetails.name,
                        labelText: 'Name',
                        helperText: '',
                        maxLength: 25,
                        errorText: state.formSubmitted && state.name.invalid
                            ? 'Please enter your name'
                            : null,
                      );
                    }),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
                  buildWhen: (previous, current) =>
                      previous.email != current.email ||
                      previous.formSubmitted != current.formSubmitted,
                  builder: (context, state) {
                    return TextFieldStyleOne(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      onChanged: (String email) => context
                          .read<UserProfileEditBloc>()
                          .emailChanged(email),
                      textInputAction: TextInputAction.done,
                      initialValue: userDetails.email,
                      labelText: 'Email',
                      helperText: '',
                      errorText: state.formSubmitted && state.email.invalid
                          ? 'Invalid Email'
                          : null,
                    );
                  },
                ),

                const Divider(),
                SizedBox(
                  height: screenHeight * 0.02,
                ),

                BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
                  buildWhen: (previous, current) =>
                      previous.email != current.email ||
                      previous.formSubmitted != current.formSubmitted,
                  builder: (context, state) {
                    return TextFieldStyleOne(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      onChanged: (String bio) => context
                          .read<UserProfileEditBloc>()
                          .bioChanged(bio),
                      textInputAction: TextInputAction.done,
                      initialValue: userDetails.bio,
                     // labelText: 'About Me',
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      hintText: 'Tell us a little about yourself!',
                    );
                  },
                ),

                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Divider(),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                // Text(
                //   "Social Media",
                //   style: Theme.of(context)
                //       .textTheme
                //       .subtitle1!
                //       .copyWith(fontWeight: FontWeight.w700),
                // ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
