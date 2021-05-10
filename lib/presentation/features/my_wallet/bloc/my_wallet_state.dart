part of 'my_wallet_bloc.dart';

class MyWalletState extends Equatable {
  final List<CardPaymentMethodModel?>? cardPaymentMethods;
  final CardPaymentMethodModel? defaultPaymentMethod;

  final bool isFetchInProgress;
  final String? errorMessage;
  final bool showLoading;
  final bool showNoInternetError;
  final bool showSystemError;

  const MyWalletState({
    this.cardPaymentMethods,
    this.defaultPaymentMethod,
    this.isFetchInProgress = true,
    this.errorMessage,
    this.showLoading = false,
    this.showNoInternetError = false,
    this.showSystemError = false,
  });

  @override
  List<Object?> get props => [
        cardPaymentMethods,
        defaultPaymentMethod,
        isFetchInProgress,
        errorMessage,
        showLoading,
        showNoInternetError,
        showSystemError
      ];

  MyWalletState copyWith({
    List<CardPaymentMethodModel?>? cardPaymentMethods,
    CardPaymentMethodModel? defaultPaymentMethod,
    bool defaultPaymentMethodCanBeNull = false,
    bool? isFetchInProgress,
    bool? showLoading,
    bool? showNoInternetError,
    bool? showSystemError,
    String? errorMessage,
  }) {
    return MyWalletState(
      cardPaymentMethods: cardPaymentMethods ?? this.cardPaymentMethods,
      defaultPaymentMethod: defaultPaymentMethod ?? (defaultPaymentMethodCanBeNull? null: this.defaultPaymentMethod),
      isFetchInProgress: isFetchInProgress ?? false,
      showLoading: showLoading?? false,
      showNoInternetError: showNoInternetError ?? false,
      showSystemError: showSystemError ?? false,
      errorMessage: errorMessage,
    );
  }
}
