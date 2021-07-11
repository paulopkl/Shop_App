import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/Product.dart';
import 'package:shop/providers/ProductsProvider.dart';
import 'package:shop/widgets/AppDrawer.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() {
    return _ProductFormScreenState();
  }
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController(); // Controlador
  final _form = GlobalKey<FormState>(); // Observer para amarrar o form
  final _formData = Map<String, Object>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final product = ModalRoute.of(context).settings.arguments as Product;

      if (product != null) {
        _formData["id"] = product.id;
        _formData["title"] = product.title;
        _formData["price"] = product.price;
        _formData["description"] = product.description;
        _formData["imageUrl"] = product.imageUrl;

        _imageUrlController.text = _formData["imageUrl"];
      } else {
        _formData["price"] = "";
      }
    }
  }

  void _updateImageUrl() {
    // Verifica de é válido
    if (isValidImageUrl(_imageUrlController.text)) setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool startsWithHttp = url.toLowerCase().startsWith("http://");
    bool startsWithHttps = url.toLowerCase().startsWith("https://");

    bool endsWithPng = url.toLowerCase().endsWith(".png");
    bool endsWithJpg = url.toLowerCase().endsWith(".jpg");
    bool endsWithJpeg = url.toLowerCase().endsWith(".jpeg");

    return (startsWithHttp || startsWithHttps) &&
        (endsWithPng || endsWithJpg || endsWithJpeg);
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void dispose() {
    // Sempre que usar um observer, deve-se liberar a memória
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
  }

  void _saveForm() {
    bool isValid = _form.currentState.validate();

    if (!isValid) return;

    _form.currentState.save(); // Form Amarrado

    final product = Product(
      id: _formData["id"],
      title: _formData["title"],
      price: _formData["price"],
      description: _formData["description"],
      imageUrl: _formData["imageUrl"],
    );

    final products = Provider.of<ProductsProvider>(context, listen: false);

    if (_formData["id"] == null) {
      products.addProduct(product);
    } else {
      products.updateProduct(product);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Formulário Produto")),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _form, // Amarra este Form
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData["title"],
                decoration: InputDecoration(labelText: "Título"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) => _formData["title"] = value,
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  bool isinvalid = value.trim().length < 3;

                  if (isEmpty || isinvalid) return "Informe um Título válido!";

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData["price"].toString(),
                decoration: InputDecoration(labelText: "Preço"),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) => _formData["price"] = double.parse(value),
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  var newPrice = double.tryParse(value);
                  bool isinvalid = newPrice == null || newPrice <= 0;

                  if (isEmpty || isinvalid) return "Informe um preço válido!";

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData["description"],
                decoration: InputDecoration(labelText: "Descrição"),
                focusNode: _descriptionFocusNode,
                keyboardType: TextInputType.multiline,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_priceFocusNode);
                // },
                maxLines: 3,
                onSaved: (value) => _formData["description"] = value,
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  bool isinvalid = value.trim().length < 10;

                  if (isEmpty || isinvalid) {
                    return "Informe uma Descrição válida com no mínimo 10" +
                        " caracteres!";
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "URL da Imagem"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) => _formData["imageUrl"] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isinvalidUrl = !isValidImageUrl(value);
                        if (isEmpty || isinvalidUrl)
                          return "Informe uma URL válido!";

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, left: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text("Informe a URL")
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
