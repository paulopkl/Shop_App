import 'package:flutter/material.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Minha Loja")),
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
        ],
      ),
      body: ProductGrid(
        showFavoriteOnly: _showFavoriteOnly,
      ),
    );
  }
}
