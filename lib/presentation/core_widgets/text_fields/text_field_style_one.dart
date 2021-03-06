import 'package:flutter/material.dart';
import 'package:yummer/config/config.dart';

class TextFieldStyleOne extends StatelessWidget {
  final Color? focusedBorder;
  final double screenWidth;
  final double screenHeight;
  final Function onChanged;
  final String? errorText;
  final String? labelText;
  final String? initialValue;
  final String? helperText;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool autofocus;
  final IconData? iconData;

  const TextFieldStyleOne({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onChanged,
    this.labelText,
    this.initialValue,
    this.errorText,
    this.helperText,
    this.hintText,
    this.maxLength,
     this.maxLines,
    this.focusedBorder,
    this.textInputAction,
    this.keyboardType,
    this.autofocus = false,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => onChanged(value),
      keyboardType: keyboardType?? TextInputType.text,
      autofocus: autofocus,
      textInputAction: textInputAction ?? TextInputAction.done,
      initialValue: initialValue,
      maxLength: maxLength,
       maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w700,
          color: AppConfig.of(context)!.theme!.captionTextColor,
        ),
        filled: true,
        fillColor: AppConfig.of(context)!.theme!.textFieldOneBackgroundColor,
        contentPadding: EdgeInsets.only(
            left: screenWidth * 0.04,
            right: screenWidth * 0.04,
            top: screenHeight * 0.022,
            bottom: screenHeight * 0.022),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppConfig.of(context)!.theme!.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: iconData != null? Icon(iconData): null,
        helperText: helperText,
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }
}
