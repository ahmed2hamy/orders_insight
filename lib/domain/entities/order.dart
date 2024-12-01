class Order {
  final String id;
  final bool isActive;
  final double price;
  final String status;
  final DateTime registered;

  Order({
    required this.id,
    required this.isActive,
    required this.price,
    required this.status,
    required this.registered,
  });
}
