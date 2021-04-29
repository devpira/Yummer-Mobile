import 'package:injectable/injectable.dart';

import 'package:yummer/data/data.dart';
import 'package:yummer/domain/restaurant/models/detailed_restaurant_model.dart';
import 'package:yummer/domain/restaurant/restaurant.dart';

@lazySingleton
class RestaurantRepository {
  final RestaurantApi _restaurantApi;

  const RestaurantRepository({
    required RestaurantApi restaurantApi,
  }) : _restaurantApi = restaurantApi;

  Future<List<BasicRestaurantModel>?> getAllBasicEnabledRestaurants() async {
    try {
      final List<BasicRestaurantModel> resultList = [];
      final result = await _restaurantApi.getAllBasicEnabledRestaurants();
      if (result == null) {
        return null;
      }
      for (final Object item in result) {
        resultList
            .add(BasicRestaurantModel.fromMap(item as Map<String, dynamic>));
      }
      print(resultList);
      return resultList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<DetailedRestaurantModel?> getDetailedRestaurantInfo(
      String restaurantId) async {
    try {
      final result = await _restaurantApi.getFullRestaurantInfo(restaurantId);
      return DetailedRestaurantModel.fromMap(result);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
