import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CardPaymentMethodModel extends Equatable {
  final String id;
  final String brand;
  final String last4;
  final int expMonth;
  final int expYear;
  final bool isExpired;
  final bool isDefault;

  const CardPaymentMethodModel({
    @required this.id,
    @required this.brand,
    @required this.last4,
    @required this.expMonth,
    @required this.expYear,
    @required this.isExpired,
    @required this.isDefault,
  });

  @override
  List<Object> get props {
    return [
      id,
      brand,
      last4,
      expMonth,
      expYear,
      isExpired,
      isDefault,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'last4': last4,
      'expMonth': expMonth,
      'expYear': expYear,
      'isExpired': isExpired,
      'isDefault': isDefault,
    };
  }

  factory CardPaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return CardPaymentMethodModel(
      id: map['id'] as String,
      brand: map['brand'] as String,
      last4: map['last4'] as String,
      expMonth: map['expMonth'] as int,
      expYear: map['expYear'] as int,
      isExpired: map['isExpired'] as bool,
      isDefault: map['isDefault'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardPaymentMethodModel.fromJson(String source) => CardPaymentMethodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CardPaymentMethodModel copyWith({
    String id,
    String brand,
    String last4,
    int expMonth,
    int expYear,
    bool isExpired,
    bool isDefault,
  }) {
    return CardPaymentMethodModel(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      last4: last4 ?? this.last4,
      expMonth: expMonth ?? this.expMonth,
      expYear: expYear ?? this.expYear,
      isExpired: isExpired ?? this.isExpired,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
