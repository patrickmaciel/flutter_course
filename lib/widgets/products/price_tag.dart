import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        // 'R\$' + products[index]['price'].toString(),
        '\$${price.toString()}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
