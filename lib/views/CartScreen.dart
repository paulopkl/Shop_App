import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/providers/OrdersProvider.dart';
import 'package:shop/widgets/CartItemWidget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);
    final textTheme =
        Theme.of(context).primaryTextTheme.headline6.copyWith(fontSize: 16);

    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCount,
              itemBuilder: (ctx, i) => CartItemWidget(cartItem: cartItems[i]),
            ),
          ),
          SizedBox(height: 10),
          Card(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Consumer<CartProvider>(
                    builder: (ctx, cart, child) => Chip(
                      label: Text(
                        "R\$ ${cart.totalAmount.toStringAsFixed(2)}",
                        style: textTheme,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  // Chip(
                  //   label: Consumer<CartProvider>(
                  //     builder: (ctx, cart, child) => Text(
                  //       "R\$ ${cart.totalAmount.toStringAsFixed(2)}",
                  //       style: textTheme,
                  //     ),
                  //   ),
                  //   backgroundColor: Theme.of(context).primaryColor,
                  // ),
                  Spacer(),
                  TextButton(
                    child: Text(
                      "comprar".toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<OrdersProvider>(context, listen: false)
                          .addOrder(cart: cart);

                      cart.clearCart();
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
