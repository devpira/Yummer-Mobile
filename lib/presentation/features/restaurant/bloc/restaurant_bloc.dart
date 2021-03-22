import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:yummer/domain/menu/menu.dart';
import 'package:yummer/domain/restaurant/models/detailed_restaurant_model.dart';
import 'package:yummer/domain/restaurant/restaurant.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

@injectable
class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository _restaurantRepository;
  final MenuRepository _menuRepository;

  RestaurantBloc({
    @required RestaurantRepository restaurantRepository,
    @required MenuRepository menuRepository,
  })  : assert(restaurantRepository != null),
        assert(menuRepository != null),
        _restaurantRepository = restaurantRepository,
        _menuRepository = menuRepository,
        super(const RestaurantState());

  @override
  Stream<RestaurantState> mapEventToState(
    RestaurantEvent event,
  ) async* {
    if (event is RestaurantEventLoadRestaurant) {
      print("LOAD RESTAURANT");
      yield state.copyWith(isRestaurantFetchInProgress: true);
      final DetailedRestaurantModel restaurant = await _restaurantRepository
          .getDetailedRestaurantInfo(event.restaurantId);
      print(restaurant);
      if (restaurant == null) {
        yield state.copyWith(
            isRestaurantFetchInProgress: false,
            errorMessage: "Failed to find restaurant. Please try again later.");
        return;
      }
      yield state.copyWith(
        isRestaurantFetchInProgress: false,
        restaurantModel: restaurant,
      );
    } else if (event is RestaurantEventLoadMenu) {
      print("LOADING MENU");
      yield state.copyWith(isMenuFetchInProgress: true);
      final MenuModel menuModel = await _menuRepository
          .getCurrentRestaurantMenyToDisplay(event.restaurantId);
      print(menuModel);

      yield state.copyWith(
        isMenuFetchInProgress: false,
        menuModel: menuModel,
      );
    } else if (event is RestaurantEventChangeCurrentMenuTab) {
      yield state.copyWith(
        currentTabIndex: event.index,
      );
    }
  }
}
