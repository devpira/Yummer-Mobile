import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'internet_connectivity_state.dart';

@lazySingleton
class InternetConnectivityCubit extends Cubit<InternetConnectivityState> {
  final Connectivity? connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetConnectivityCubit({required this.connectivity})
      : super(InternetLoading()) {
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity!.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        emit(InternetConnected());
      } else {
        emit(InternetDisconnected());
      }
    });
  }


  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
