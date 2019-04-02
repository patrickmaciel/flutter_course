import 'package:flutter/material.dart';

import '../widgets/products/products.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scopedmodels/main.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
//  _ProductsPageState(MainModel model) : super(model);
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

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
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          ),
        ],
      ),
      body: _buildProductsList(),
    );
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('No Products found!'));
        if (model.displayedProducts.length > 0 && !model.isLoading) {
          content = Products();
        } else if (model.isLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        }

        return content;
      },
    );
  }
}
