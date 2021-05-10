import 'package:flutter/material.dart';
import 'package:yummer/config/config.dart';

class ButtonTextField extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final Function onPressed;
  final IconData? icon;
  final String label;
  final String? value;
  final String? errorMessage;
  final Color? iconColor;

  const ButtonTextField({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    this.icon,
    required this.label,
    this.value,
    required this.onPressed,
    this.errorMessage,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value == null || value!.isEmpty ? 54 : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppConfig.of(context)!.theme!.textFieldOneBackgroundColor,

          elevation: 0,
          side: BorderSide(color: Colors.grey[300]!),

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),

        onPressed: () => onPressed(),

        child: Container(
          padding: value != null && value!.isNotEmpty
              ? EdgeInsets.symmetric(vertical: screenHeight * 0.013)
              : null,
          child: Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: screenWidth * 0.05,
                  color: iconColor ?? Colors.grey[500],
                ),
              if (icon != null)
                SizedBox(
                  width: screenWidth * 0.03,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w700,
                          color: AppConfig.of(context)!.theme!.captionTextColor,
                        ),
                      ),
                    ),
                    if (value != null && value!.isNotEmpty)
                      SizedBox(
                        height: screenHeight * 0.004,
                      ),
                    if (value != null && value!.isNotEmpty)
                      Text(
                        value!,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    if (errorMessage != null && errorMessage!.isNotEmpty)
                      SizedBox(
                        height: screenHeight * 0.004,
                      ),
                    if (errorMessage != null && errorMessage!.isNotEmpty)
                      Text(
                        "Required",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Colors.red[500],
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.032,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
