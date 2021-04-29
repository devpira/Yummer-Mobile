import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yummer/config/config.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core/internet_connectivity/internet_connectivity.dart';
import 'package:yummer/domain/user_detail/user_detail.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/user_detail/user_detail.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'package:yummer/presentation/features/user_profile_creation/user_profile_creation.dart';
import 'package:formz/formz.dart';

class CreateUserDetailsPage extends StatelessWidget {
  const CreateUserDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CreateUserDetailCubit>(
        create: (_) => CreateUserDetailCubit(
          userDetailRepository: getIt<UserDetailRepository>(),
          authenticationBloc: getIt<AuthenticationBloc>(),
          internetConnectivityCubit: getIt<InternetConnectivityCubit>(),
        ),
        child: _CreateUserDetailsPageForm(),
      ),
    );
  }
}

class _CreateUserDetailsPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<CreateUserDetailCubit, CreateUserDetailState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          context
              .read<UserDetailBloc>()
              .add(UserDetailLoadRequested(user: user));
        }
      },
      child: LayoutBuilder(
        builder: (context, size) {
          final double height = size.maxHeight;
          final double width = size.maxWidth;

          return BaseForm(
            height: height,
            width: width,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: height * 0.03,
                // ),

                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                  height: screenHeight * 0.23,
                  child: Center(
                    child: Image.asset(
                      "assets/images/create_profile_img.png",
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                _buildTitle(context, width, "Complete Your Account"),
                SizedBox(
                  height: height * 0.03,
                ),
                _NameInput(
                  user: user,
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                _EmailInput(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                _SaveButton(),
                SizedBox(
                  height: height * 0.04,
                ),
                Align(
                  child: InkWell(
                    onTap: () => context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested()),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: width * 0.035,
                        fontFamily: 'Quicksand',
                        color: AppConfig.of(context)!.theme!.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context, double width, String title) {
    return SizedBox(
      //width: width * 0.8,
      child: Text(
        title,
        style: TextStyle(
          color: AppConfig.of(context)!.theme!.accentColor,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w900,
          fontSize: MediaQuery.of(context).size.height * 0.025,
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  final UserModel user;
  final double screenHeight;
  final double screenWidth;

  const _NameInput({
    required this.user,
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    String? name;
    if (user != null && user.name != null) {
      name = user.name;
    }

    return BlocBuilder<CreateUserDetailCubit, CreateUserDetailState>(
      buildWhen: (previous, current) =>
          previous.name != current.name ||
          previous.formSubmitted != current.formSubmitted,
      builder: (context, state) {
        return TextFieldStyleOne(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onChanged: (String name) =>
              context.read<CreateUserDetailCubit>().nameChanged(name),
          textInputAction: TextInputAction.next,
          initialValue: name,
          labelText: 'Name',
          helperText: '',
          maxLength: 25,
          errorText: state.formSubmitted && state.name.invalid
              ? 'Please enter your name'
              : null,
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const _EmailInput({
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateUserDetailCubit, CreateUserDetailState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.formSubmitted != current.formSubmitted,
      builder: (context, state) {
        return TextFieldStyleOne(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onChanged: (String email) =>
              context.read<CreateUserDetailCubit>().emailChanged(email),
          textInputAction: TextInputAction.done,
          labelText: 'Email',
          helperText: '',
          errorText: state.formSubmitted && state.email.invalid
              ? 'Invalid Email'
              : null,
        );
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateUserDetailCubit, CreateUserDetailState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AccentRaisedButton(
          onClick: () =>
              context.read<CreateUserDetailCubit>().createUserDetails(),
          text: "SAVE",
          showProgressBar: state.status.isSubmissionInProgress,
          elevation: 0,
          textStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}
