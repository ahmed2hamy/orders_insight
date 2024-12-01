import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:orders_insight/constants/constants.dart';
import 'package:orders_insight/domain/entities/order.dart';
import 'package:orders_insight/domain/use_cases/get_order_insights.dart';

class OrderProvider extends ChangeNotifier {
  final GetOrderInsights getOrderInsights;
  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  String _selectedStatus = kAllString;

  List<Order> get filteredOrders => _filteredOrders;

  String get selectedStatus => _selectedStatus;

  OrderProvider({required this.getOrderInsights});

  Future<void> loadInsights() async {
    _allOrders = await getOrderInsights();
    _applyFilters();
  }

  void updateStatusFilter(String status) {
    _selectedStatus = status;
    _applyFilters();
  }

  List<FlSpot> getChartData() {
    final groupedOrders = <DateTime, int>{};

    for (final order in _filteredOrders) {
      final date = DateTime(order.registered.year, order.registered.month);
      groupedOrders[date] = (groupedOrders[date] ?? 0) + 1;
    }

    final data = groupedOrders.entries
        .map((entry) => FlSpot(
              entry.key.millisecondsSinceEpoch.toDouble(),
              entry.value.toDouble(),
            ))
        .toList();

    data.sort((a, b) => a.x.compareTo(b.x));
    return data;
  }

  void _applyFilters() {
    _filteredOrders = _allOrders.where((order) {
      if (_selectedStatus != kAllString &&
          order.status.toLowerCase() != _selectedStatus.toLowerCase()) {
        return false;
      }
      return true;
    }).toList();
    notifyListeners();
  }
}
