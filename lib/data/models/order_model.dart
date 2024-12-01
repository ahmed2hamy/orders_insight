import 'package:orders_insight/domain/entities/order.dart';

class OrderModel extends Order {
  OrderModel({
    required super.id,
    required super.isActive,
    required super.price,
    required super.status,
    required super.registered,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      isActive: json['isActive'],
      price:
          double.parse(json['price'].replaceAll(',', '').replaceAll('\$', '')),
      status: json['status'],
      registered: DateTime.parse(json['registered']),
    );
  }
}
