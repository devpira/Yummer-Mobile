import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:yummer/domain/restaurant/restaurant.dart';
part 'home_restaurant_event.dart';
part 'home_restaurant_state.dart';

@injectable
class HomeRestaurantBloc
    extends Bloc<HomeRestaurantEvent, HomeRestaurantState> {
  final RestaurantRepository _restaurantRepository;

  HomeRestaurantBloc({
    @required RestaurantRepository restaurantRepository,
  })  : assert(restaurantRepository != null),
        _restaurantRepository = restaurantRepository,
        super(const HomeRestaurantState(restuarantList: [])) {
    add(HomeRestaurantEventLoadAllBasicRestaurants());
  }

  @override
  Stream<HomeRestaurantState> mapEventToState(
    HomeRestaurantEvent event,
  ) async* {
    if (event is HomeRestaurantEventLoadAllBasicRestaurants) {
      print("LOAD RESTAURANTS");
      yield state.copyWith(isFetchingInProgress: true);
      final List<BasicRestaurantModel> restaurantList = await _restaurantRepository.getAllBasicEnabledRestaurants();
      print(restaurantList.length);
      yield state.copyWith(restuarantList: restaurantList?? []);
    }
  }
}
