import 'package:flutter/material.dart';
// import './pages/products.dart';
import './pages/auth.dart';
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
        accentColor: Colors.deepPurple
      ),
      home: AuthPage(),
    );
  }
}
