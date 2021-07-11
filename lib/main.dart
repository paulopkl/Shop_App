import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/CartProvider.dart';
import 'package:shop/providers/OrdersProvider.dart';
import 'package:shop/providers/ProductsProvider.dart';
import 'package:shop/utils/AppRoutes.dart';
import 'package:shop/views/CartScreen.dart';
import 'package:shop/views/OrdersScreen.dart';
import 'package:shop/views/ProductDetailScreen.dart';
import 'package:shop/views/ProductFormScreen.dart';
import 'package:shop/views/ProductsOverviewScreen.dart';
import 'package:shop/views/ProductsScreen.dart';
// import 'package:shop/providers/CounterProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Retorna multiplos providers como objeto no estado global
        ChangeNotifierProvider(create: (_) => new ProductsProvider()),
        ChangeNotifierProvider(create: (_) => new CartProvider()),
        ChangeNotifierProvider(create: (_) => new OrdersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: "Lato",
        ),
        // home: ProductOverviewScreen(),
        routes: {
          AppRoutes.HOME: (ctx) => ProductOverviewScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Minha Loja'),
//       ),
//       body: Center(
//         child: Text('Vamos desenvolver uma loja?'),
//       ),
//     );
//   }
// }
