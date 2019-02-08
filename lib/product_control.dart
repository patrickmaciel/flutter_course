import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function pressedFunction;

  ProductControl(this.pressedFunction);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            pressedFunction({'title' : 'Sweets', 'imageUrl': 'assets/food.jpg'});
          },
          child: Text('Add Product'),
        );
  }

}