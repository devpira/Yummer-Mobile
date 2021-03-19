import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/presentation/core/internet_connectivity/internet_connectivity.dart';
import 'package:yummer/presentation/core_widgets/core_widgets.dart';
import 'base_form.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<VerifyEmailCubit>(
        create: (_) => VerifyEmailCubit(
          getIt<AuthenticationRepository>(),
          getIt<InternetConnectivityCubit>(),
        ),
        child: _VerifyEmailView(),
      ),
    );
  }
}

class _VerifyEmailView extends StatefulWidget {
  @override
  __VerifyEmailViewState createState() => __VerifyEmailViewState();
}

class __VerifyEmailViewState extends State<_VerifyEmailView> {
  @override
  void initState() {
    super.initState();
    getIt<AuthenticationRepository>().initVerifyEmailDynamicLinks(
      onSuccess: (UserModel user) => context
          .read<AuthenticationBloc>()
          .add(AuthenticationUserChanged(user)),
      onError: (e) => context.read<VerifyEmailCubit>().emitVerifyEmailFailure(
            "Failed to verify email. Please restart the app or try again.",
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyEmailCubit, VerifyEmailState>(
      listener: (context, state) {
        if (state is VerifyEmailFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
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
              children: [
                Container(
                  width: width,
                  margin: EdgeInsets.only(top: height * 0.28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTitle(context, width, "Verify Email"),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                SizedBox(
                  width: width * 0.7,
                  child: const Text(
                    "A confirmation email was sent to your email address with a link.",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                  width: width * 0.6,
                  child: const Text(
                    "Please click on the link in the email to verify.",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                _ResendEmailButton()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context, double width, String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w700,
        fontSize: MediaQuery.of(context).size.width * 0.1,
      ),
    );
  }
}

class _ResendEmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return PrimaryRaisedButton(
          onClick: () =>
              context.read<VerifyEmailCubit>().resendEmailVerification(),
          text: "RESEND EMAIL",
          showProgressBar: state is ResendingVerifyEmailInProgress,
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
