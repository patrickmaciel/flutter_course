import 'package:flutter/material.dart';

import 'models/product.dart';
import 'widgets/products/products.dart';

class ProductManager extends StatelessWidget {
  final List<Product> products;

  ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    print('[ProductManager Widget] build()');
    return Column(
      children: [
        Expanded(child: Products(products)),
      ],
    );
  }
}
