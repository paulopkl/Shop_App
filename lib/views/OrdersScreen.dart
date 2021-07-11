import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/OrdersProvider.dart';
import 'package:shop/widgets/AppDrawer.dart';
import 'package:shop/widgets/OrderWidget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrdersProvider orders = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Meus Pedidos"),
        ),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
      ),
    );
  }
}
