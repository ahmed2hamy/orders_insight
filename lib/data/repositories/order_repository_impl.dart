import 'package:orders_insight/data/data_sources/local/local_data_source.dart';
import 'package:orders_insight/domain/entities/order.dart';
import 'package:orders_insight/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final LocalDataSource localDataSource;

  OrderRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Order>> getOrders() async {
    return await localDataSource.fetchOrders();
  }
}
