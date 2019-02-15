import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _inputEmail;
  String _inputPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (String value) {
                  setState(() {
                    _inputEmail = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _inputPassword = value;
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text('Login'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () {
                  print(_inputEmail);
                  print(_inputPassword);
                  Navigator.pushReplacementNamed(context, '/products'
                      // MaterialPageRoute(
                      //     builder: (BuildContext context) => ProductsPage()),
                      );
                },
              ),
            ],
          ),
        ));
  }
}
