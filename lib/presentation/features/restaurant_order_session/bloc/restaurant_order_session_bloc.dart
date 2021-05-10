import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:yummer/domain/order_session/models/models.dart';

part 'restaurant_order_session_event.dart';
part 'restaurant_order_session_state.dart';

@injectable
class RestaurantOrderSessionBloc extends Bloc<RestaurantOrderSessionEvent, RestaurantOrderSessionState> {
  RestaurantOrderSessionBloc() : super(const RestaurantOrderSessionState());

  @override
  Stream<RestaurantOrderSessionState> mapEventToState(
    RestaurantOrderSessionEvent event,
  ) async* {
    if (event is RestaurantOrderSessionEventStartOrderSession) {
      yield state.copyWith(orderSessionModel: event.orderSessionModel);
    }
  }
}
