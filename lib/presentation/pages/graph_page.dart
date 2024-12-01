import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:orders_insight/constants/constants.dart';
import 'package:orders_insight/presentation/manager/order_provider.dart';
import 'package:orders_insight/presentation/widgets/filter_widget.dart';
import 'package:provider/provider.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context, listen: false);

    provider.loadInsights();

    return Scaffold(
      appBar: AppBar(
        title: const Text(kGraphPageTitle),
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

                final chartData = provider.getChartData();

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22.0,
                            getTitlesWidget: (value, meta) {
                              final date = DateTime.fromMillisecondsSinceEpoch(
                                  value.toInt());
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${date.month}/${date.year}',
                                  style: kGreyBodyTextStyle.copyWith(
                                      fontSize: 12.0),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32.0,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  value.toInt().toString(),
                                  style: kGreyBodyTextStyle.copyWith(
                                      fontSize: 12.0),
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        getDrawingVerticalLine: (value) => FlLine(
                            color: kGreyColor.shade300, strokeWidth: 1.0),
                        getDrawingHorizontalLine: (value) => FlLine(
                            color: kGreyColor.shade300, strokeWidth: 1.0),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border:
                            Border.all(color: kGreyColor.shade300, width: 1.0),
                      ),

                      lineBarsData: [
                        LineChartBarData(
                          spots: chartData,
                          isCurved: true,
                          color: kBlueAccentColor,
                          barWidth: 4.0,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                kBlueAccentColor.withOpacity(0.3),
                                kTransparentColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
