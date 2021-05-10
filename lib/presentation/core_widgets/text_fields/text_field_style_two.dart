import 'package:flutter/material.dart';
import 'package:yummer/config/config.dart';


class TextFieldStyleTwo extends StatelessWidget {
  final Color? focusedBorder;
  final double screenWidth;
  final Function? onChanged;
  final String? errorMessage;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final String? helperText;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final IconData? iconData;
  final Color? iconColor;
  final Function? validator;
  final Function? onSaved;
  final TextStyle? labelStyle;
  final bool alignLabelWithHint;
  final bool autofocus;

  const TextFieldStyleTwo({
    Key? key,
    required this.screenWidth,
    required this.onChanged,
    this.labelText,
    this.initialValue,
    this.errorMessage,
    this.helperText,
    this.hintText,
    this.maxLength,
    this.maxLines,
    this.focusedBorder,
    this.textInputAction,
    this.textInputType,
    this.iconData,
    this.iconColor,
    this.validator,
    this.onSaved,
    this.labelStyle,
    this.alignLabelWithHint = false,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('createUserDetailForm_firstInput_textField'),
      onChanged: onChanged != null ? (value) => onChanged!(value) : null,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: textInputType,
      maxLength: maxLength,
      maxLines: maxLines,
      initialValue: initialValue,
      autofocus: autofocus,
      validator: validator != null
          ? (String? value) => validator!(value) as String?
          : null,
      onSaved: onSaved != null ? (String? value) => onSaved!(value) : null,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: screenWidth * 0.035,
      ),
      decoration: InputDecoration(
        prefixIcon: iconData != null
            ? Icon(
                iconData,
                color: iconColor ?? Colors.grey[500],
              )
            : null,
        alignLabelWithHint: alignLabelWithHint,
        labelText: labelText,
        labelStyle: labelStyle ??
            Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
        helperText: helperText,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.04)),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        // isDense: true,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.04)),
          borderSide: BorderSide(color: Colors.red[500]!),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.04)),
          borderSide: BorderSide(color: Colors.red[500]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.04)),
          borderSide: BorderSide(
              color: focusedBorder ?? AppConfig.of(context)!.theme!.primaryColor),
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
