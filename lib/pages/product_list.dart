import 'package:flutter/material.dart';

import '../models/product.dart';
import 'product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index].title),
          background: Container(color: Colors.red),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              deleteProduct(index);
            } else if (direction == DismissDirection.startToEnd) {
              print('Start to end');
            } else {
              print('Else direction');
            }
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index].image),
                ),
//          leading: Image.asset(products[index].imageUrl),
//          leading: new Image(
////            image: Image.asset(products[index].imageUrl),
//            image: AssetImage(products[index].imageUrl),
////            height: 40.0,
//            width: 50.0,
//            fit: BoxFit.fitWidth,
//          ),
                title: Text(products[index].title),
                subtitle: Text('R\$${products[index].price.toString()}'),
                trailing: _buildEditButton(context, index),
              ),
              Divider()
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }

  IconButton _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage(
                product: products[index],
                updateProduct: updateProduct,
                productIndex: index,
              );
            },
          ),
        );
      },
    );
  }
}
