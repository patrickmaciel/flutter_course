import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  ProductPage(this.title, this.imageUrl, this.price, this.description);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Jesus é Rei!'),
            content: Text('É a nossa rocha.'),
            actions: <Widget>[
              FlatButton(
                  child: Text('Discard'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child: Text('Continue'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false); // block back button
        return Future.value(false); // ignore the default request
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        // body: Center(child: Text('On the product page'),),
        body: ListView(
          children: <Widget>[
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(imageUrl),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          TitleDefault(title),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              '\$${price.toString()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.keyboard_backspace),
                            color: Theme.of(context).accentColor,
                            highlightColor: Colors.red,
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).accentColor,
                            onPressed: () => _showWarningDialog(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DecoratedBox(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    child: Text('Brazil'),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(description),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
