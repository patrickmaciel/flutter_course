import 'package:flutter/material.dart';
import 'price_tag.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product['imageUrl']),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  product['title'],
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arvo',
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                PriceTag(product['price']),
              ],
            ),
          ),
          DecoratedBox(
            child: Padding(
              child: Text('Union Square, San Francisco'),
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Colors.lightBlue,
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + productIndex.toString()),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + productIndex.toString()),
              )
            ],
          )
        ],
      ),
    );
  }
}
