part of 'internet_connectivity_cubit.dart';

abstract class InternetConnectivityState extends Equatable {
  const InternetConnectivityState();

  @override
  List<Object> get props => [];
}

class InternetLoading extends InternetConnectivityState {}

class InternetConnected extends InternetConnectivityState {}

class InternetDisconnected extends InternetConnectivityState {}
