import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/ProductsProvider.dart';
import 'package:shop/utils/AppRoutes.dart';
import 'package:shop/views/ProductDetailScreen.dart';
import 'package:shop/views/ProductsOverviewScreen.dart';
// import 'package:shop/providers/CounterProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // CounterProvider(
        //   child:
        ChangeNotifierProvider(
      create: (_) => ProductsProvider(), // Retornou um objeto no estado global
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: "Lato",
        ),
        home: ProductOverviewScreen(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          // AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(product: null),
          // AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(product: null),
          // AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(product: null),
        },
      ),
    );
    // );
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
