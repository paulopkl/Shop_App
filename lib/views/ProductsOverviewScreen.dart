import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/utils/AppRoutes.dart';
import 'package:shop/widgets/AppDrawer.dart';
import 'package:shop/widgets/Badge.dart';
import 'package:shop/widgets/ProductGrid.dart';
// import 'package:provider/provider.dart';
// import 'package:shop/providers/ProductsProvider.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    // final ProductsProvider productsProvider = Provider.of(context);
    final CartProvider cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Center(child: Text("Minha Loja")),
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Somente Favoritos"),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text("Todos"),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite)
                  _showFavoriteOnly = true;
                // productsProvider.showFavoriteOnly();
                else
                  _showFavoriteOnly = false;
                // productsProvider.showAll();
              });
            },
          ),
          Consumer<CartProvider>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.CART,
                  // arguments:
                );
              },
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              color: Theme.of(context).accentColor, // Cor padrão
              child: child,
            ),
          ),
        ],
      ),
      body: ProductGrid(showFavoriteOnly: _showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}
