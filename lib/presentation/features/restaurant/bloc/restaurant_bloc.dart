import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:yummer/domain/menu/menu.dart';
import 'package:yummer/domain/order_cart/models/order_cart_item_model.dart';
import 'package:yummer/domain/order_cart/models/order_cart_model.dart';
import 'package:yummer/domain/order_session/order_session.dart';
import 'package:yummer/domain/order_session/repository/repository.dart';
import 'package:yummer/domain/restaurant/models/detailed_restaurant_model.dart';
import 'package:yummer/domain/restaurant/restaurant.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

@injectable
class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository _restaurantRepository;
  final MenuRepository _menuRepository;
  final OrderSessionRepository _orderSessionRepository;

  RestaurantBloc({
    required RestaurantRepository restaurantRepository,
    required MenuRepository menuRepository,
    required OrderSessionRepository orderSessionRepository,
  })   : _restaurantRepository = restaurantRepository,
        _menuRepository = menuRepository,
        _orderSessionRepository = orderSessionRepository,
        super(const RestaurantState());

  @override
  Stream<RestaurantState> mapEventToState(
    RestaurantEvent event,
  ) async* {
    if (event is RestaurantEventLoadRestaurant) {
      print("LOAD RESTAURANT");
      yield state.copyWith(isRestaurantFetchInProgress: true);
      final DetailedRestaurantModel? restaurant = await _restaurantRepository
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
      final MenuModel? menuModel = await _menuRepository
          .getCurrentRestaurantMenyToDisplay(event.restaurantId);
      print(menuModel);

      yield state.copyWith(
        isMenuFetchInProgress: false,
        menuModel: menuModel,
      );
    } else if (event is RestaurantEventLoadCart) {
      print("LOADING Cart");

      yield state.copyWith(
        orderCartModel: OrderCartModel(
          id: event.restaurantId,
          restaurantId: event.restaurantId,
          cartItems: [],
        ),
      );
    } else if (event is RestaurantEventAddToCart) {
      print("Adding to Cart");

      yield addToCart(event.productItem);
    } else if (event is RestaurantEventChangeCurrentMenuTab) {
      yield state.copyWith(
        currentTabIndex: event.index,
      );
    } else if (event is RestaurantEventPlaceOrder) {
      yield state.copyWith(isOrderPlaceRequestInProgress: true);
      yield await placeOrder(event.paymentMethodId);
    }
  }

  RestaurantState addToCart(MenuProductModel productItem) {
    final oldCart = state.orderCartModel!;
    final oldCartItems = oldCart.cartItems;
    oldCartItems.add(OrderCartItemModel(
        productId: productItem.id,
        quantity: 1,
        priceUnitAmount: productItem.priceUnitAmount,
        currencyCode: productItem.currencyCode,
        name: productItem.name,
        imageUrls: productItem.imageUrls));
    return state.copyWith(
      orderCartModel: oldCart.copyWith(
        totalPriceUnitAmount:
            oldCart.totalPriceUnitAmount + productItem.priceUnitAmount!,
        cartItems: oldCartItems,
      ),
    );
  }

  Future<RestaurantState> placeOrder(String? paymentMethodId) async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return state.copyWith(
          errorMessage: "No internet connection. Please try again.");
    }

    final List<Map<String, dynamic>> orderItems = [];

    state.orderCartModel!.cartItems.forEach((item) {
      orderItems.add({
        "productId": item.productId,
        "quantity": item.quantity,
      });
    });

    if (orderItems.isEmpty) {
      return state.copyWith(
          errorMessage: "Cart cannot be empty. Please try again.");
    }

    print(orderItems.length);

    try {
      final orderSessionModel =
          await _orderSessionRepository.createOrderSession(
        restaurantId: state.restaurantModel!.id!,
        restaurantPosAccountId: state.restaurantModel!.posAccountId!,
        paymentMethodId: paymentMethodId!,
        orderItems: orderItems,
        totalCostUnitAmount: state.orderCartModel!.totalPriceUnitAmount,
      );

      if (orderSessionModel == null || orderSessionModel.id == null)
        throw Exception();

      return state.copyWith(orderSessionModel: orderSessionModel);
    } on OrderSessionException catch (e) {
      return state.copyWith(errorMessage: e.toString());
    } catch (e) {
      return state.copyWith(
          errorMessage: "Failed to place order. Please try again.");
    }
  }
}
