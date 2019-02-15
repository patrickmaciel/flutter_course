import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue;
  String descriptionValue;
  double priceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              onChanged: (String value) {
                setState(() {
                  titleValue = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 4,
              onChanged: (String value) {
                setState(() {
                  descriptionValue = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                setState(() {
                  priceValue = double.parse(value);
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: () {
                final Map<String, dynamic> product = {
                  'title': titleValue,
                  'price': priceValue,
                  'description': descriptionValue,
                  'imageUrl': 'assets/food.jpg'
                };
                widget.addProduct(product);
                Navigator.pushReplacementNamed(context, '/products');
              },
            ),
          ],
        ));

    // return Center(child: Text('Create Product'));

    // return Center(
    //   child: RaisedButton(
    //     child: Text('Save'),
    //     onPressed: () {
    //       showModalBottomSheet(
    //           context: context,
    //           builder: (BuildContext context) {
    //             return Center(
    //               child: Text('Modal'),
    //             );
    //           });
    //     },
    //   ),
    // );
  }
}
