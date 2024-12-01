import 'package:flutter/material.dart';
import 'package:orders_insight/constants/constants.dart';
import 'package:orders_insight/data/data_sources/local/local_data_source.dart';
import 'package:orders_insight/data/repositories/order_repository_impl.dart';
import 'package:orders_insight/domain/use_cases/get_order_insights.dart';
import 'package:orders_insight/presentation/manager/order_provider.dart';
import 'package:orders_insight/presentation/pages/graph_page.dart';
import 'package:orders_insight/presentation/pages/metrics_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const OrdersInsightApp());
}

class OrdersInsightApp extends StatelessWidget {
  const OrdersInsightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderProvider(
        getOrderInsights: GetOrderInsights(
          repository: OrderRepositoryImpl(
            localDataSource: LocalDataSourceImpl(),
          ),
        ),
      ),
      child: MaterialApp(
        title: kAppTitle,
        theme: kAppLightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const MetricsPage(),
          '/graph': (context) => const GraphPage(),
        },
      ),
    );
  }
}
