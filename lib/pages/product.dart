import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scopedmodels/products.dart';
import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;

  ProductPage(this.productIndex);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Jesus é Rei!'),
            content: Text('É a nossa rocha.'),
            actions: <Widget>[
              FlatButton(
                  child: Text('Discard'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child: Text('Continue'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false); // block back button
        return Future.value(false); // ignore the default request
      },
      child: ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
          final Product product = model.products[productIndex];
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            // body: Center(child: Text('On the product page'),),
            body: ListView(
              children: <Widget>[
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(product.image),
                    _buildTitlePrice(context, product),
                    _buildAddress(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(product.description),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  DecoratedBox _buildAddress() {
    return DecoratedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        child: Text('Brazil'),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
    );
  }

  Container _buildTitlePrice(BuildContext context, Product product) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              TitleDefault(product.title),
              SizedBox(
                width: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  '\$${product.price.toString()}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.keyboard_backspace),
                color: Theme.of(context).accentColor,
                highlightColor: Colors.red,
                onPressed: () => Navigator.pop(context, false),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).accentColor,
                onPressed: () => _showWarningDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
