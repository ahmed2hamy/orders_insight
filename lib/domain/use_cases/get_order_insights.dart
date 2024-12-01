import 'package:orders_insight/domain/entities/order.dart';
import 'package:orders_insight/domain/repositories/order_repository.dart';

class GetOrderInsights {
  final OrderRepository repository;

  GetOrderInsights({required this.repository});

  Future<List<Order>> call() async {
    final orders = await repository.getOrders();

    return orders;
  }
}
