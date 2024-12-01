import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:orders_insight/data/models/order_model.dart';

abstract class LocalDataSource {
  Future<List<OrderModel>> fetchOrders();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<List<OrderModel>> fetchOrders() async {
    final jsonString = await rootBundle.loadString('assets/orders.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((json) => OrderModel.fromJson(json)).toList();
  }
}
