import 'package:flutter/material.dart';
import 'package:shop/providers/Product.dart';
import 'package:shop/providers/CounterProvider.dart.txt';

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
        title: Center(
          child: Text(product.title),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "R\$ ${product.price}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
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
