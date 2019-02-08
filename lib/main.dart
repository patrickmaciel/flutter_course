import 'package:flutter/material.dart';
// import './pages/products.dart';
import './pages/auth.dart';
import './pages/product.dart';
import './pages/products.dart';
import './pages/product_list.dart';
import './pages/product_create.dart';
import './pages/products_admin.dart';
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
class MyApp extends StatelessWidget {
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
        '/login': (BuildContext context) => AuthPage(),
        '/': (BuildContext context) => ProductsPage(),
        '/products/admin': (BuildContext context) => ProductsAdminPage(),
        '/products/my': (BuildContext context) => ProductListPage(),
        '/products/create': (BuildContext context) => ProductCreatePage(),
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
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductPage());
        }

        return null;
      },
    );
  }
}
