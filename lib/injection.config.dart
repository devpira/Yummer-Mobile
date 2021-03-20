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
import 'config/config.dart' as _i12;
import 'config/firebase_config.dart' as _i8;
import 'config/theme.dart' as _i3;
import 'data/data.dart' as _i16;
import 'data/graphql_api/user_detail_api.dart' as _i11;
import 'domain/user_detail/repository/user_detail_repository.dart' as _i15;
import 'domain/user_detail/user_detail.dart' as _i14;
import 'injection.dart' as _i18;
import 'presentation/core/authentication/bloc/authentication_bloc.dart' as _i17;
import 'presentation/core/error_handling/bloc/error_handling_bloc.dart' as _i7;
import 'presentation/core/internet_connectivity/cubit/internet_connectivity_cubit.dart'
    as _i10;
import 'presentation/core/user_detail/bloc/user_detail_bloc.dart' as _i13;
import 'presentation/features/a_home/cubit/home_page_cubit.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
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
  gh.lazySingleton<_i10.InternetConnectivityCubit>(() =>
      _i10.InternetConnectivityCubit(connectivity: get<_i6.Connectivity>()));
  gh.lazySingleton<_i11.UserDetailApi>(
      () => _i11.UserDetailApi(appValues: get<_i12.AppValues>()));
  gh.factory<_i13.UserDetailBloc>(() => _i13.UserDetailBloc(
      userDetailRepository: get<_i14.UserDetailRepository>()));
  gh.lazySingleton<_i15.UserDetailRepository>(() =>
      _i15.UserDetailRepository(userDetailApi: get<_i16.UserDetailApi>()));
  gh.factory<_i17.AuthenticationBloc>(() => _i17.AuthenticationBloc(
      authenticationRepository: get<_i5.AuthenticationRepository>()));
  return get;
}

class _$ExternalLibraries extends _i18.ExternalLibraries {}
