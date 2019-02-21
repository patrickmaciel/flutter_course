import 'package:flutter/material.dart';
import '../product_manager.dart';
import './products_admin.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductsPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false, // remove o hamburguer
              title: Text('Choose'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Products Admin'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/products/admin');
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            ListTile(
              title: Text('Rota Inexistente'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/oque');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Products Page'),
      ),
      body: ProductManager(products),
    );
  }
}
