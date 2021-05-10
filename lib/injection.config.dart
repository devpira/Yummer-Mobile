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
import 'config/config.dart' as _i9;
import 'config/firebase_config.dart' as _i10;
import 'config/theme.dart' as _i3;
import 'data/data.dart' as _i17;
import 'data/graphql_api/menu_api.dart' as _i15;
import 'data/graphql_api/my_wallet_api.dart' as _i18;
import 'data/graphql_api/order_session_api.dart' as _i21;
import 'data/graphql_api/restaurant_api.dart' as _i22;
import 'data/graphql_api/user_detail_api.dart' as _i28;
import 'data/graphql_api/user_follow_api.dart' as _i32;
import 'domain/file_storage/file_storage.dart' as _i36;
import 'domain/file_storage/repository/file_storage_repository.dart' as _i8;
import 'domain/menu/menu.dart' as _i24;
import 'domain/menu/repository/menu_repository.dart' as _i16;
import 'domain/my_wallet/repository/my_wallet_repository.dart' as _i19;
import 'domain/order_session/order_session.dart' as _i25;
import 'domain/order_session/repository/order_session_repository.dart' as _i20;
import 'domain/restaurant/repository/restaurant_repository.dart' as _i27;
import 'domain/restaurant/restaurant.dart' as _i13;
import 'domain/user/repository/user_detail_repository.dart' as _i31;
import 'domain/user/repository/user_follow_repository.dart' as _i34;
import 'domain/user/user_detail.dart' as _i30;
import 'injection.dart' as _i41;
import 'presentation/core/authentication/bloc/authentication_bloc.dart' as _i38;
import 'presentation/core/error_handling/bloc/error_handling_bloc.dart' as _i7;
import 'presentation/core/internet_connectivity/cubit/internet_connectivity_cubit.dart'
    as _i14;
import 'presentation/core/user_detail/bloc/user_detail_bloc.dart' as _i29;
import 'presentation/features/a_home/cubit/home_page_cubit.dart' as _i11;
import 'presentation/features/home_restaurant/bloc/home_restaurant_bloc.dart'
    as _i12;
import 'presentation/features/my_wallet/bloc/my_wallet_bloc.dart' as _i40;
import 'presentation/features/my_wallet/cubit/my_wallet_add_payment_cubit.dart'
    as _i39;
import 'presentation/features/restaurant/bloc/restaurant_bloc.dart' as _i23;
import 'presentation/features/restaurant_order_session/bloc/restaurant_order_session_bloc.dart'
    as _i26;
import 'presentation/features/user_follow/bloc/user_follow_bloc.dart' as _i33;
import 'presentation/features/user_profile_edit/bloc/user_profile_edit_bloc.dart'
    as _i35;
import 'presentation/features/user_search/bloc/user_search_bloc.dart'
    as _i37; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i8.FileStorageRepository>(
      () => _i8.FileStorageRepository(appValues: get<_i9.AppValues>()));
  gh.lazySingleton<_i10.FirebaseConfig>(() => _i10.FirebaseConfig());
  gh.factory<_i11.HomePageCubit>(() => _i11.HomePageCubit());
  gh.factory<_i12.HomeRestaurantBloc>(() => _i12.HomeRestaurantBloc(
      restaurantRepository: get<_i13.RestaurantRepository>()));
  gh.lazySingleton<_i14.InternetConnectivityCubit>(() =>
      _i14.InternetConnectivityCubit(connectivity: get<_i6.Connectivity>()));
  gh.lazySingleton<_i15.MenuApi>(
      () => _i15.MenuApi(appValues: get<_i9.AppValues>()));
  gh.lazySingleton<_i16.MenuRepository>(
      () => _i16.MenuRepository(menuApi: get<_i17.MenuApi>()));
  gh.lazySingleton<_i18.MyWalletApi>(
      () => _i18.MyWalletApi(appValues: get<_i9.AppValues>()));
  gh.lazySingleton<_i19.MyWalletRepository>(
      () => _i19.MyWalletRepository(myWalletApi: get<_i17.MyWalletApi>()));
  gh.lazySingleton<_i20.OrderSessionRepository>(() =>
      _i20.OrderSessionRepository(
          orderSessoionApi: get<_i17.OrderSessoionApi>()));
  gh.lazySingleton<_i21.OrderSessoionApi>(
      () => _i21.OrderSessoionApi(appValues: get<_i9.AppValues>()));
  gh.lazySingleton<_i22.RestaurantApi>(
      () => _i22.RestaurantApi(appValues: get<_i9.AppValues>()));
  gh.factory<_i23.RestaurantBloc>(() => _i23.RestaurantBloc(
      restaurantRepository: get<_i13.RestaurantRepository>(),
      menuRepository: get<_i24.MenuRepository>(),
      orderSessionRepository: get<_i25.OrderSessionRepository>()));
  gh.factory<_i26.RestaurantOrderSessionBloc>(
      () => _i26.RestaurantOrderSessionBloc());
  gh.lazySingleton<_i27.RestaurantRepository>(() =>
      _i27.RestaurantRepository(restaurantApi: get<_i17.RestaurantApi>()));
  gh.lazySingleton<_i28.UserDetailApi>(
      () => _i28.UserDetailApi(appValues: get<_i9.AppValues>()));
  gh.factory<_i29.UserDetailBloc>(() => _i29.UserDetailBloc(
      userDetailRepository: get<_i30.UserDetailRepository>(),
      userFollowRepository: get<_i30.UserFollowRepository>()));
  gh.lazySingleton<_i31.UserDetailRepository>(() =>
      _i31.UserDetailRepository(userDetailApi: get<_i17.UserDetailApi>()));
  gh.lazySingleton<_i32.UserFollowApi>(
      () => _i32.UserFollowApi(appValues: get<_i9.AppValues>()));
  gh.factory<_i33.UserFollowBloc>(() => _i33.UserFollowBloc(
      userFollowRepository: get<_i30.UserFollowRepository>()));
  gh.lazySingleton<_i34.UserFollowRepository>(() =>
      _i34.UserFollowRepository(userFollowApi: get<_i32.UserFollowApi>()));
  gh.factory<_i35.UserProfileEditBloc>(() => _i35.UserProfileEditBloc(
      fileStorageRepository: get<_i36.FileStorageRepository>(),
      userDetailRepository: get<_i30.UserDetailRepository>()));
  gh.factory<_i37.UserSearchBloc>(() => _i37.UserSearchBloc(
      userDetailRepository: get<_i30.UserDetailRepository>()));
  gh.factory<_i38.AuthenticationBloc>(() => _i38.AuthenticationBloc(
      authenticationRepository: get<_i5.AuthenticationRepository>()));
  gh.factory<_i39.MyWalletAddPaymentCubit>(() => _i39.MyWalletAddPaymentCubit(
      appValues: get<_i9.AppValues>(),
      myWalletRepository: get<_i19.MyWalletRepository>()));
  gh.factory<_i40.MyWalletBloc>(() =>
      _i40.MyWalletBloc(myWalletRepository: get<_i19.MyWalletRepository>()));
  return get;
}

class _$ExternalLibraries extends _i41.ExternalLibraries {}
