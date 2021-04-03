part of 'my_wallet_bloc.dart';

class MyWalletState extends Equatable {
  final List<CardPaymentMethodModel> cardPaymentMethods;

  final bool isFetchInProgress;
  final String errorMessage;
  final bool showNoInternetError;
  final bool showSystemError;

  const MyWalletState({
    this.cardPaymentMethods,
    this.isFetchInProgress = true,
    this.errorMessage,
    this.showNoInternetError = false,
    this.showSystemError = false,
  });
  
  @override
  List<Object> get props => [cardPaymentMethods, isFetchInProgress, errorMessage, showNoInternetError, showSystemError];

  MyWalletState copyWith({
    List<CardPaymentMethodModel> cardPaymentMethods,
    bool isFetchInProgress,
    bool showNoInternetError,
    bool showSystemError,
    String errorMessage,
  }) {
    return MyWalletState(
      cardPaymentMethods: cardPaymentMethods ?? this.cardPaymentMethods,
      isFetchInProgress: isFetchInProgress ?? false,
      showNoInternetError: showNoInternetError?? false,
      showSystemError: showSystemError?? false,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

