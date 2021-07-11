import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/ProductsProvider.dart';
import 'package:shop/utils/AppRoutes.dart';
import 'package:shop/widgets/AppDrawer.dart';
import 'package:shop/widgets/ProductItem.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsProvider products = Provider.of<ProductsProvider>(context);
    final productsItems = products.items;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Center(child: Text("Gerenciar Produtos")),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  ProductItem(product: productsItems[i]),
                  Divider(),
                ],
              );
            }),
      ),
    );
  }
}
