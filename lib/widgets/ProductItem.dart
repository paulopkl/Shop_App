import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/providers/Product.dart';
import 'package:shop/utils/AppRoutes.dart';
import 'package:shop/views/ProductDetailScreen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PROVIDERS
    final Product product = Provider.of<Product>(context, listen: false);
    final CartProvider cart = Provider.of<CartProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.65),
          leading: Consumer<Product>(
            // child: Text("Nunca Muda"), // Serve para ser referenciado em uma
            //   parte que nunca irá mudar, nunca sofrerá alterações em seu valor
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () => product.toggleFavorite(),
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product);
              // print(cart.itemsCount.toString());
            },
          ),
        ),
      ),
    );
  }
}
