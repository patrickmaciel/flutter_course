import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

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

  _buildTitleTextFormField() {
    return TextFormField(
      onSaved: (String value) {
        _formData['title'] = value;
      },
      initialValue: widget.product == null ? '' : widget.product['title'],
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
      initialValue: widget.product == null ? '' : widget.product['description'],
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
      initialValue:
          widget.product == null ? '' : widget.product['price'].toString(),
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
    if (widget.product == null) {
      widget.addProduct(_formData);
    } else {
      widget.updateProduct(widget.productIndex, _formData);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        MediaQuery.of(context).size.width > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget pageContent = GestureDetector(
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

    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
