import 'package:flutter/material.dart';
import './pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products([this.products = const []]) {
    print('[Products Widget] Construtor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['imageUrl']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + index.toString()
                    // MaterialPageRoute(
                    //   builder: (BuildContext context) => ProductPage(products[index]['title'], products[index]['imageUrl']),
                    // ),
                    ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productCards;

    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    } else {
      // productCards = Center(
      //   child: Text('Nenhum produto encontrado'),
      // );
      productCards = Container(); // empty container
    }

    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build');
    return _buildProductList();
  }
}
