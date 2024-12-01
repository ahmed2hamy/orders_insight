import 'package:flutter/material.dart';
import 'package:orders_insight/constants/constants.dart';
import 'package:orders_insight/presentation/manager/order_provider.dart';
import 'package:provider/provider.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          return DropdownButton<String>(
            value: provider.selectedStatus,
            items: [
              kAllString,
              kOrderedString,
              kDeliveredString,
              kReturnedString
            ]
                .map((status) =>
                    DropdownMenuItem(value: status, child: Text(status)))
                .toList(),
            onChanged: (value) => provider.updateStatusFilter(value!),
          );
        },
      ),
    );
  }
}
