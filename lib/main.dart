import 'package:flutter/material.dart';
// import './pages/products.dart';
import './pages/auth.dart';
import './pages/product.dart';
import './pages/products.dart';
import './pages/product_list.dart';
import './pages/product_create.dart';
import './pages/products_admin.dart';
import './pages/unknown.dart';
// import 'package:flutter/rendering.dart';
// import './product_manager.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}
// void main() => runApp(MyApp());

// <Widget> generic type
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // core root widget - object  based
    // name arguments
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      // home: AuthPage(),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/404': (BuildContext context) => UnknownPage(),
        // '/': (BuildContext context) => ProductsPage(_products, _addProduct, _deleteProduct),
        '/products': (BuildContext context) => ProductsPage(_products),
        '/products/admin': (BuildContext context) =>
            ProductsAdminPage(_addProduct, _deleteProduct),
        '/products/my': (BuildContext context) => ProductListPage(),
        '/products/create': (BuildContext context) =>
            ProductCreatePage(_addProduct),
        // '/products/': (BuildContext context) => ProductPage(String, String),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements =
            settings.name.split('/'); // products/1 product,1
        if (pathElements[0] != '') {
          return null;
        }

        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(
                  _products[index]['title'], _products[index]['imageUrl']));
        }

        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          // builder: (BuildContext context) => UnknownPage(),
          builder: (BuildContext context) => ProductsPage(_products),
        );
      },
    );
  }
}
