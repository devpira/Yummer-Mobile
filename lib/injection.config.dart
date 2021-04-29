// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:authentication_repository/authentication_repository.dart'
    as _i5;
import 'package:connectivity_plus/connectivity_plus.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'config/app_values.dart' as _i4;
import 'config/config.dart' as _i14;
import 'config/firebase_config.dart' as _i8;
import 'config/theme.dart' as _i3;
import 'data/data.dart' as _i16;
import 'data/graphql_api/menu_api.dart' as _i13;
import 'data/graphql_api/my_wallet_api.dart' as _i17;
import 'data/graphql_api/order_session_api.dart' as _i20;
import 'data/graphql_api/restaurant_api.dart' as _i21;
import 'data/graphql_api/user_detail_api.dart' as _i27;
import 'domain/menu/menu.dart' as _i23;
import 'domain/menu/repository/menu_repository.dart' as _i15;
import 'domain/my_wallet/repository/my_wallet_repository.dart' as _i18;
import 'domain/order_session/order_session.dart' as _i24;
import 'domain/order_session/repository/order_session_repository.dart' as _i19;
import 'domain/restaurant/repository/restaurant_repository.dart' as _i26;
import 'domain/restaurant/restaurant.dart' as _i11;
import 'domain/user_detail/repository/user_detail_repository.dart' as _i30;
import 'domain/user_detail/user_detail.dart' as _i29;
import 'injection.dart' as _i34;
import 'presentation/core/authentication/bloc/authentication_bloc.dart' as _i31;
import 'presentation/core/error_handling/bloc/error_handling_bloc.dart' as _i7;
import 'presentation/core/internet_connectivity/cubit/internet_connectivity_cubit.dart'
    as _i12;
import 'presentation/core/user_detail/bloc/user_detail_bloc.dart' as _i28;
import 'presentation/features/a_home/cubit/home_page_cubit.dart' as _i9;
import 'presentation/features/home_restaurant/bloc/home_restaurant_bloc.dart'
    as _i10;
import 'presentation/features/my_wallet/bloc/my_wallet_bloc.dart' as _i33;
import 'presentation/features/my_wallet/cubit/my_wallet_add_payment_cubit.dart'
    as _i32;
import 'presentation/features/restaurant/bloc/restaurant_bloc.dart' as _i22;
import 'presentation/features/restaurant_order_session/bloc/restaurant_order_session_bloc.dart'
    as _i25; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final externalLibraries = _$ExternalLibraries();
  gh.lazySingleton<_i3.AppThemeData>(() => _i3.AppThemeData());
  gh.lazySingleton<_i4.AppValues>(() => _i4.AppValues());
  gh.lazySingleton<_i5.AuthenticationRepository>(
      () => externalLibraries.authenticationRepository);
  gh.lazySingleton<_i6.Connectivity>(() => externalLibraries.connectivity);
  gh.lazySingleton<_i7.ErrorHandlingBloc>(() => _i7.ErrorHandlingBloc());
  gh.lazySingleton<_i8.FirebaseConfig>(() => _i8.FirebaseConfig());
  gh.factory<_i9.HomePageCubit>(() => _i9.HomePageCubit());
  gh.factory<_i10.HomeRestaurantBloc>(() => _i10.HomeRestaurantBloc(
      restaurantRepository: get<_i11.RestaurantRepository>()));
  gh.lazySingleton<_i12.InternetConnectivityCubit>(() =>
      _i12.InternetConnectivityCubit(connectivity: get<_i6.Connectivity>()));
  gh.lazySingleton<_i13.MenuApi>(
      () => _i13.MenuApi(appValues: get<_i14.AppValues>()));
  gh.lazySingleton<_i15.MenuRepository>(
      () => _i15.MenuRepository(menuApi: get<_i16.MenuApi>()));
  gh.lazySingleton<_i17.MyWalletApi>(
      () => _i17.MyWalletApi(appValues: get<_i14.AppValues>()));
  gh.lazySingleton<_i18.MyWalletRepository>(
      () => _i18.MyWalletRepository(myWalletApi: get<_i16.MyWalletApi>()));
  gh.lazySingleton<_i19.OrderSessionRepository>(() =>
      _i19.OrderSessionRepository(
          orderSessoionApi: get<_i16.OrderSessoionApi>()));
  gh.lazySingleton<_i20.OrderSessoionApi>(
      () => _i20.OrderSessoionApi(appValues: get<_i14.AppValues>()));
  gh.lazySingleton<_i21.RestaurantApi>(
      () => _i21.RestaurantApi(appValues: get<_i14.AppValues>()));
  gh.factory<_i22.RestaurantBloc>(() => _i22.RestaurantBloc(
      restaurantRepository: get<_i11.RestaurantRepository>(),
      menuRepository: get<_i23.MenuRepository>(),
      orderSessionRepository: get<_i24.OrderSessionRepository>()));
  gh.factory<_i25.RestaurantOrderSessionBloc>(
      () => _i25.RestaurantOrderSessionBloc());
  gh.lazySingleton<_i26.RestaurantRepository>(() =>
      _i26.RestaurantRepository(restaurantApi: get<_i16.RestaurantApi>()));
  gh.lazySingleton<_i27.UserDetailApi>(
      () => _i27.UserDetailApi(appValues: get<_i14.AppValues>()));
  gh.factory<_i28.UserDetailBloc>(() => _i28.UserDetailBloc(
      userDetailRepository: get<_i29.UserDetailRepository>()));
  gh.lazySingleton<_i30.UserDetailRepository>(() =>
      _i30.UserDetailRepository(userDetailApi: get<_i16.UserDetailApi>()));
  gh.factory<_i31.AuthenticationBloc>(() => _i31.AuthenticationBloc(
      authenticationRepository: get<_i5.AuthenticationRepository>()));
  gh.factory<_i32.MyWalletAddPaymentCubit>(() => _i32.MyWalletAddPaymentCubit(
      appValues: get<_i14.AppValues>(),
      myWalletRepository: get<_i18.MyWalletRepository>()));
  gh.factory<_i33.MyWalletBloc>(() =>
      _i33.MyWalletBloc(myWalletRepository: get<_i18.MyWalletRepository>()));
  return get;
}

class _$ExternalLibraries extends _i34.ExternalLibraries {}
