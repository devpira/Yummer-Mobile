import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:yummer/data/data.dart';
import 'package:yummer/domain/menu/menu.dart';

@lazySingleton
class MenuRepository {
  final MenuApi _menuApi;

  const MenuRepository({
    required MenuApi menuApi,
  })  : assert(menuApi != null),
        _menuApi = menuApi;

  Future<MenuModel?> getCurrentRestaurantMenyToDisplay(
      String restaurantId) async {
    try {
      final result =
          await (_menuApi.getCurrentRestaurantMenyToDisplay(restaurantId) as FutureOr<Map<String, dynamic>>);
      return MenuModel.fromMap(result);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
