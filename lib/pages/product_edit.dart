import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scopedmodels/main.dart';
import '../widgets/helpers/ensure-visible.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'imageUrl': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  _buildTitleTextFormField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        onSaved: (String value) {
          _formData['title'] = value;
        },
        initialValue: product == null ? '' : product.title,
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
      ),
    );
  }

  _buildDescriptionTextFormField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        onSaved: (String value) {
          _formData['description'] = value;
        },
        decoration: InputDecoration(labelText: 'Description'),
        maxLines: 4,
        initialValue: product == null ? '' : product.description,
        validator: (String value) {
//        if (value.trim().length <= 0) {
//          return 'Title is required';
//        }
          if (value.isEmpty || value.length < 10) {
            return 'Ta errado';
          }
        },
      ),
    );
  }

  _buildPriceTextFormField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        onSaved: (String value) {
          _formData['price'] = double.parse(value);
        },
        decoration: InputDecoration(labelText: 'Price'),
        keyboardType: TextInputType.number,
        initialValue: product == null ? '' : product.price.toString(),
        validator: (String value) {
//        if (value.trim().length <= 0) {
//          return 'Title is required';
//        }
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'Ta errado';
          }
        },
      ),
    );
  }

  _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedProductIndex == null) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['imageUrl'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/products')
          .then((_) => setSelectedProduct(null)));
    } else {
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['imageUrl'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/products')
          .then((_) => setSelectedProduct(null)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final double deviceWidth = MediaQuery.of(context).size.width;
        final double targetWidth = MediaQuery.of(context).size.width > 550.0
            ? 500.0
            : deviceWidth * 0.95;
        final double targetPadding = deviceWidth - targetWidth;
        final Widget pageContent =
            _buildPageContent(context, targetPadding, model.selectedProduct);

        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }

  GestureDetector _buildPageContent(
      BuildContext context, double targetPadding, Product product) {
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
              _buildTitleTextFormField(product),
              _buildDescriptionTextFormField(product),
              _buildPriceTextFormField(product),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RaisedButton(
                child: Text('Save'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () => _submitForm(
                    model.addProduct,
                    model.updateProduct,
                    model.selectProduct,
                    model.selectedProductIndex),
              );
      },
    );
  }
}
