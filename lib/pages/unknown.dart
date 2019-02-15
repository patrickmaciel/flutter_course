import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ops')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              child: Center(child: Text('Opa')), padding: EdgeInsets.all(10.0)),
          Container(
            child: RaisedButton(
              child: Text('Essa página não existe'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/'
                    // MaterialPageRoute(
                    //     builder: (BuildContext context) => ProductsPage()),
                    );
              },
            ),
            padding: EdgeInsets.all(10.0),
          ),
        ],
      ),
    );
  }
}
