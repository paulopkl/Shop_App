import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/Product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class CartProvider with ChangeNotifier {
  // SEMPRE CHAME O notifyListeners();

  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => ({..._items});

  int get itemsCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    this._items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) {
        return CartItem(
          id: existingItem.id,
          productId: product.id,
          title: existingItem.title,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        );
      });
    } else {
      _items.putIfAbsent(
        product.id,
        () {
          return CartItem(
            id: Random().nextDouble().toString(),
            productId: product.id,
            title: product.title,
            quantity: 1,
            price: product.price,
          );
        },
      );
    }

    notifyListeners(); // Atualiza o Estado Global
  }

  void removerSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId].quantity == 1)
      _items.remove(productId);
    else {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: productId,
          title: existingItem.title,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) _items.remove(productId);

    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
