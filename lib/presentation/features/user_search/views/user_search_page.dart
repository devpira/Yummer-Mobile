import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yummer/injection.dart';
import 'package:yummer/presentation/core/core.dart';
import 'package:yummer/presentation/features/feature.dart';

class UserSearchPage extends StatelessWidget {
  const UserSearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserSearchBloc>(
      create: (_) => getIt<UserSearchBloc>(),
      child: const _UserSearchView(),
    );
  }
}

class _UserSearchView extends StatelessWidget {
  const _UserSearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // leading: IconButton(
          //     icon: const Icon(FontAwesomeIcons.solidTimesCircle),
          //     onPressed: () => context.router.pop()),
          title: Text(
            "Search User",
            style: TextStyle(
                fontSize: screenWidth * 0.05, fontWeight: FontWeight.w700),
          ),
        ),
        body: _UserSearchBody(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
        ));
  }
}

class _UserSearchBody extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;

  const _UserSearchBody({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  __UserSearchBodyState createState() => __UserSearchBodyState();
}

class __UserSearchBodyState extends State<_UserSearchBody> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return ConstrainedBox(
      constraints: const BoxConstraints(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: widget.screenWidth * 0.02,
                vertical: widget.screenHeight * 0.01),
            child: Card(
              margin:
                  EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 3,
              child: TextField(
                controller: _textController,
                onChanged: (String? text) {
                  if (text != null) {
                    context
                        .read<UserSearchBloc>()
                        .add(UserSearchEventSearche(searchTerm: text));
                  }
                },
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: widget.screenWidth * 0.035),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                autofocus: true,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.only(
                      left: widget.screenWidth * 0.04,
                      right: widget.screenWidth * 0.04,
                      top: widget.screenHeight * 0.023,
                      bottom: widget.screenHeight * 0.017),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[500]!, width: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Start typing to search...",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(FontAwesomeIcons.search),
                ),
              ),
            ),
          ),
          Expanded(
              child: _ListView(
            screenHeight: widget.screenHeight,
            screenWidth: widget.screenWidth,
            textEditingController: _textController,
          ))
        ],
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final TextEditingController textEditingController;

  const _ListView(
      {Key? key,
      required this.screenHeight,
      required this.screenWidth,
      required this.textEditingController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UserSearchBloc, UserSearchState>(
        buildWhen: (previous, current) =>
            previous.pageState != current.pageState,
        builder: (context, state) {
          if (state.pageState is UserSearchPageStateInitial) {
            return SizedBox(
              width: screenWidth * 0.8,
              height: double.infinity,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    "Start typing above to search. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
             
                ],
              ),
            );
          } else if (state.pageState is UserSearchPageStateKeepTyping) {
            return SizedBox(
              width: screenWidth * 0.8,
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  const Text(
                    "Please keep typing to narrow your search.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (state.pageState is UserSearchPageStateLoading) {
            return LoadingScreen();
          } else if (state.pageState
              is UserSearchPageStateNoResultsFound) {
            return SizedBox(
              width: screenWidth * 0.8,
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.06,
                  ),
                  const Text(
                    "Sorry we couldn't find anything for your search. Please try a different search.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (state.pageState
              is UserSearchPageStateResultsLoaded) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
              ),
              child: ListView.builder(
                itemCount: state.resultList!.length,
                itemBuilder: (context, int index) {
                  final item = state.resultList![index];
                  return UserDetailRowItem(userDetailModel: item);
                },
              ),
            );
          } else if (state.pageState is UserSearchPageStateError) {
            // ignore: invalid_assignment
            final pageState =
                state.pageState as UserSearchPageStateError;
            return SystemErrorPage(
              errorMessage: pageState.errorMessage,
            );
          } else if (state.pageState is UserSearchPageStateNoInternet) {
            return const NoInternetPage();
          } else {
            return const SystemErrorPage();
          }
        });
  }
}