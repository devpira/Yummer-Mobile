import 'package:flutter/material.dart';
import 'package:yummer/config/app_config.dart';

class BaseForm extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final Function? onBackClicked;

  const BaseForm({
    required this.child,
    required this.height,
    required this.width,
    this.onBackClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConfig.of(context)!.theme!.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.07,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.07, bottom: height * 0.03),
            //width: width * 0.6,
            child: Image.asset(
              "assets/images/yummer_label.png",
              // width: width * 0.6,
            ),
          ),
          Expanded(
            child: Card(
              elevation: 3,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              margin: const EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (onBackClicked != null)
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.041, vertical: height * 0.01),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_sharp),
                          onPressed: () => onBackClicked!(),
                          iconSize: width * 0.09,
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.07),
                      child: child,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
