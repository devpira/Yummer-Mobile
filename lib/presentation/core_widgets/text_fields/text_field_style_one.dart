import 'package:flutter/material.dart';
import 'package:yummer/config/config.dart';

class TextFieldStyleOne extends StatelessWidget {
  final Color focusedBorder;
  final double screenWidth;
  final Function onChanged;
  final String errorMessage;
  final String labelText;
  final String initialValue;
  final String helperText;
  final int maxLength;
  final TextInputAction textInputAction;
  final IconData iconData;
  final Color iconColor;

  const TextFieldStyleOne(
      {Key key,
      @required this.screenWidth,
      @required this.onChanged,
      this.labelText,
      this.initialValue,
      this.errorMessage,
      this.helperText,
      this.maxLength,
      this.focusedBorder,
      this.textInputAction,
      this.iconData,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return TextFormField(
      key: const Key('createUserDetailForm_firstInput_textField'),
      onChanged: (value) => onChanged(value),
      textInputAction: textInputAction ?? TextInputAction.next,
      maxLength: maxLength,
      initialValue: initialValue,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: screenWidth * 0.035),
      decoration: InputDecoration(
        prefixIcon: iconData != null
            ? Icon(
                iconData,
                color: iconColor ?? Colors.grey[500],
              )
            : null,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.subtitle2.copyWith(
              fontWeight: FontWeight.bold,
            ),
        helperText: helperText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.04)),
          borderSide: BorderSide(color: Colors.grey[400]),
        ),
        // isDense: true,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.04)),
          borderSide: BorderSide(color: Colors.red[500]),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.04)),
          borderSide: BorderSide(color: Colors.red[500]),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.04)),
          borderSide: BorderSide(
              color: focusedBorder ?? AppConfig.of(context).theme.primaryColor),
        ),
        errorStyle: TextStyle(
          color: Colors.red[500],
          fontWeight: FontWeight.w500,
          fontSize: screenWidth * 0.032,
        ),
        errorText: errorMessage,
      ),
    );
  }
}
