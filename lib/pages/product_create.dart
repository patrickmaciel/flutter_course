import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'imageUrl': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _buildTitleTextFormField() {
    return TextFormField(
      onSaved: (String value) {
        _formData['title'] = value;
      },
      validator: (String value) {
//        if (value.trim().length <= 0) {
//          return 'Title is required';
//        }
        if (value.isEmpty || value.length < 5) {
          return 'Ta errado';
        }
      },
//      autovalidate: true,
      decoration: InputDecoration(
        labelText: 'Title',
      ),
    );
  }

  _buildDescriptionTextFormField() {
    return TextFormField(
      onSaved: (String value) {
        _formData['description'] = value;
      },
      decoration: InputDecoration(labelText: 'Description'),
      maxLines: 4,
      validator: (String value) {
//        if (value.trim().length <= 0) {
//          return 'Title is required';
//        }
        if (value.isEmpty || value.length < 10) {
          return 'Ta errado';
        }
      },
    );
  }

  _buildPriceTextFormField() {
    return TextFormField(
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
      decoration: InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      validator: (String value) {
//        if (value.trim().length <= 0) {
//          return 'Title is required';
//        }
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Ta errado';
        }
      },
    );
  }

  _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    widget.addProduct(Product(
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      image: _formData['imageUrl'],
    ));
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        MediaQuery.of(context).size.width > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        // esconde o teclado se clicar fora da área
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey, // global key identifier
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextFormField(),
              _buildDescriptionTextFormField(),
              _buildPriceTextFormField(),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text('Save'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
