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
import 'config/firebase_config.dart' as _i7;
import 'config/theme.dart' as _i3;
import 'injection.dart' as _i10;
import 'presentation/core/authentication/bloc/authentication_bloc.dart' as _i9;
import 'presentation/core/internet_connectivity/cubit/internet_connectivity_cubit.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i7.FirebaseConfig>(() => _i7.FirebaseConfig());
  gh.lazySingleton<_i8.InternetConnectivityCubit>(() =>
      _i8.InternetConnectivityCubit(connectivity: get<_i6.Connectivity>()));
  gh.factory<_i9.AuthenticationBloc>(() => _i9.AuthenticationBloc(
      authenticationRepository: get<_i5.AuthenticationRepository>()));
  return get;
}

class _$ExternalLibraries extends _i10.ExternalLibraries {}
