import 'package:equatable/equatable.dart';


class OrderCartItemModel extends Equatable {
  final String? productId;
  final int quantity;
  final int? priceUnitAmount;
  final String? currencyCode;
  final String? name;
  final List<String> imageUrls;
  
  const OrderCartItemModel({
    required this.productId,
    required this.quantity,
    required this.priceUnitAmount,
    required this.currencyCode,
    required this.name,
    required this.imageUrls,
  });

  @override
  List<Object?> get props {
    return [
      productId,
      quantity,
      priceUnitAmount,
      currencyCode,
      name,
      imageUrls,
    ];
  }
}
