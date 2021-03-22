import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:yummer/config/config.dart';

import 'package:yummer/domain/menu/menu.dart';
import 'package:yummer/presentation/core_widgets/buttons/buttons.dart';

class RestaurantMenuItemPage extends StatelessWidget {
  final MenuProductModel productItem;

  const RestaurantMenuItemPage({
    @required this.productItem,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final List<int> value = [2];
    final List<S2Choice<int>> frameworks = [
      S2Choice<int>(value: 1, title: 'Ionic'),
      S2Choice<int>(value: 2, title: 'Flutter'),
      S2Choice<int>(value: 3, title: 'React Native'),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: productItem.id,
                  child: Container(
                    height: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(screenWidth * 0.03),
                          bottomRight: Radius.circular(screenWidth * 0.03)),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://health.clevelandclinic.org/wp-content/uploads/sites/3/2015/08/hotDogsWorstDiabetesFood-956129522-770x533-1.jpg"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  productItem.name,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      color: AppConfig.of(context).theme.offsetHeadingColor,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productItem.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: productItem.modiferGroups
                      .map((ProductModifierGroupModel item) => Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ListTileTheme(
                              dense: true,
                              tileColor: AppConfig.of(context)
                                  .theme
                                  .lightGreyBackground,
                              child: ExpansionTile(
                                title: Text("Choice of ${item.name}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppConfig.of(context)
                                              .theme
                                              .offsetHeadingColor,
                                        )),
                                subtitle: Text(
                                    item.minSelection == 0
                                        ? "Optional"
                                        : "Required - Min (${item.minSelection}) Max (${item.maxSelection})",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontWeight: FontWeight.w400)),
                                children: [
                                  SmartSelect<int>.multiple(
                                    title: 'Frameworks',
                                    value: value,
                                    choiceItems: frameworks ,
                                    onChange: (state) =>{},
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
                // Theme(
                //   data: ThemeData().copyWith(dividerColor: Colors.transparent),
                //   child: ListTileTheme(
                //     dense: true,
                //     tileColor: AppConfig.of(context).theme.lightGreyBackground,
                //     child: ExpansionTile(
                //       title: Text("Choice of Bread",
                //           style: Theme.of(context).textTheme.subtitle1.copyWith(
                //                 fontWeight: FontWeight.w700,
                //                 color: AppConfig.of(context)
                //                     .theme
                //                     .offsetHeadingColor,
                //               )),
                //       subtitle: Text("Required",
                //           style: Theme.of(context)
                //               .textTheme
                //               .caption
                //               .copyWith(fontWeight: FontWeight.w400)),
                //       children: [const Text("hello")],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.04, left: screenWidth * 0.02),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.03),
              child: AccentRaisedButton(
                onClick: () {},
                elevation: 7,
                text: "SELECT",
              ),
            ),
          )
        ],
      ),
    );
  }
}
