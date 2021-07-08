import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/CartProvider.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    this.id,
    this.total,
    this.products,
    this.date,
  });
}

class OrdersProvider with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  void addOrder({CartProvider cart}) {
    // final combine = (t, item) => t + (item.price * item.quantity);
    // final total = products.fold(0.0, combine);

    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        date: DateTime.now(),
        products: cart.items.values.toList(),
      ),
    );

    notifyListeners();
  }

  // void removeOrder(List<CartItem> products, {double total}) {}
}
