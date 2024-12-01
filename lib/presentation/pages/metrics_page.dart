import 'package:flutter/material.dart';
import 'package:orders_insight/constants/constants.dart';
import 'package:orders_insight/presentation/manager/order_provider.dart';
import 'package:orders_insight/presentation/widgets/filter_widget.dart';
import 'package:provider/provider.dart';

class MetricsPage extends StatelessWidget {
  const MetricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context, listen: false);

    provider.loadInsights();

    return Scaffold(
      appBar: AppBar(
        title: const Text(kMetricsPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.pushNamed(context, '/graph'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const FilterWidget(),
          Expanded(
            child: Consumer<OrderProvider>(
              builder: (context, provider, child) {
                if (provider.filteredOrders.isEmpty) {
                  return const Center(child: Text(kNoDataString));
                }

                final totalOrders = provider.filteredOrders.length;
                final totalPrice = provider.filteredOrders.fold(
                  0.0,
                  (sum, order) => sum + order.price,
                );
                final averagePrice =
                    totalOrders == 0 ? 0.0 : totalPrice / totalOrders;
                final returns = provider.filteredOrders
                    .where((order) =>
                        order.status.toLowerCase() ==
                        kReturnedString.toLowerCase())
                    .length;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMetricCard(
                        title: kTotalOrdersString,
                        value: '$totalOrders',
                        icon: Icons.shopping_cart,
                        color: kBlueAccentColor,
                      ),
                      const SizedBox(height: 16.0),
                      _buildMetricCard(
                        title: kAveragePriceString,
                        value: '\$${averagePrice.toStringAsFixed(2)}',
                        icon: Icons.attach_money,
                        color: kGreenColor,
                      ),
                      const SizedBox(height: 16.0),
                      _buildMetricCard(
                        title: kNumberOfReturnsString,
                        value: '$returns',
                        icon: Icons.reply,
                        color: kRedAccentColor,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, size: 28.0, color: color),
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: kSubHeaderTextStyle),
                Text(
                  value,
                  style: kHeaderTextStyle.copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
