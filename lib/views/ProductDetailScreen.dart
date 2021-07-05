import 'package:flutter/material.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/providers/CounterProvider.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      // body: Column(
      //   children: <Widget>[
      //     Text(CounterProvider.of(context).state.value.toString()),
      //     ElevatedButton(
      //       child: Text("+"),
      //       onPressed: () {
      //         setState(() {
      //           // context.dependOnInheritedWidgetOfExactType<CounterProvider>().state.increment();
      //           // CounterProvider.of(context).state.increment();
      //           // print(CounterProvider.of(context).state.value);
      //         });
      //       },
      //     )
      //   ],
      // ),
    );
  }
}
