import 'package:flutter/material.dart';

import 'product_edit.dart';
import 'product_list.dart';
import '../scopedmodels/main.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel model;
  ProductsAdminPage(this.model);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('Products Page'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/products'
                      // MaterialPageRoute(
                      //   builder: (BuildContext context) => ProductsPage(),
                      // ),
                      );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Products Admin'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Create Products', icon: Icon(Icons.create)),
              Tab(text: 'My Products', icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(),
            ProductListPage(model),
          ],
        ),
      ),
    );
  }
}
