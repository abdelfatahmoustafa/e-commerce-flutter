import 'cart_item.dart';

class Order {
  final List<CartItem> items;
  final double totalPrice;
  final String date;

  Order({required this.items, required this.totalPrice, required this.date});

  Map<String, dynamic> toJson() => {
    'items': items.map((item) => item.toJson()).toList(),
    'totalPrice': totalPrice,
    'date': date,
  };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    items: (json['items'] as List).map((i) => CartItem.fromJson(i)).toList(),
    totalPrice: json['totalPrice'].toDouble(),
    date: json['date'],
  );
}
