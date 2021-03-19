import 'package:flutter/material.dart';
import 'package:yummer/config/config.dart';

class AccentRaisedButton extends StatelessWidget {
  final Function onClick;
  final String text;
  final double height;
  final double width;
  final bool showProgressBar;
  final double elevation;
  final TextStyle textStyle;

  const AccentRaisedButton({
    @required this.onClick,
    @required this.text,
    this.height = 0,
    this.width = 0,
    this.showProgressBar = false,
    this.elevation = 3,
    this.textStyle = const TextStyle(
        color: Colors.white,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w700),
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: (height > 0) ? height * 0.06 : height,
      width: width,
      child: RaisedButton(
        elevation: elevation,
        color: AppConfig.of(context).theme.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () => onClick(),
        child: (!showProgressBar)
            ? Text(
                text,
                style: textStyle,
              )
            : Center(
                child: SizedBox(
                  width: width * 0.04,
                  height: width * 0.04,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
      ),
    );
  }
}
