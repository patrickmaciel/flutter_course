import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/auth.dart';
import './pages/product.dart';
import './pages/product_edit.dart';
import './pages/product_list.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/unknown.dart';
import 'scopedmodels/main.dart';
// import './pages/products.dart';

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
  @override
  Widget build(BuildContext context) {
    // core root widget - object  based
    // name arguments
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
          buttonColor: Colors.black,
//        buttonTheme: ButtonThemeData(
//          textTheme: TextTheme(TextSty),
//        ),
        ),
        // home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/404': (BuildContext context) => UnknownPage(),
          // '/': (BuildContext context) => ProductsPage(_products, _addProduct, _deleteProduct),
          '/products': (BuildContext context) => ProductsPage(model),
          '/products/admin': (BuildContext context) => ProductsAdminPage(),
          '/products/my': (BuildContext context) => ProductListPage(),
          '/products/create': (BuildContext context) => ProductEditPage(),
//            ProductCreatePage(),
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
                builder: (BuildContext context) => ProductPage(index));
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            // builder: (BuildContext context) => UnknownPage(),
            builder: (BuildContext context) => ProductsPage(model),
          );
        },
      ),
    );
  }
}
