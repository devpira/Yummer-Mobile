import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'restaurant_order_session_event.dart';
part 'restaurant_order_session_state.dart';

@injectable
class RestaurantOrderSessionBloc extends Bloc<RestaurantOrderSessionEvent, RestaurantOrderSessionState> {
  RestaurantOrderSessionBloc() : super(RestaurantOrderSessionInitial());

  @override
  Stream<RestaurantOrderSessionState> mapEventToState(
    RestaurantOrderSessionEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
