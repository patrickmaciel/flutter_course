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
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.dstATop,
              ),
              image: AssetImage('assets/background.jpg'),
              // image: Image.asset('assets/background.jpg'),
            ),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String value) {
                      setState(() {
                        _inputEmail = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.9,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    onChanged: (String value) {
                      setState(() {
                        _inputPassword = value;
                      });
                    },
                  ),
                  // Switch(
                  //   value: true,
                  //   onChanged: (bool) {},

                  // ),
                  SwitchListTile(
                    value: _acceptTerms,
                    onChanged: (bool value) {
                      setState(() {
                        _acceptTerms = value;
                      });
                    },
                    title: Text('Accept Terms'),
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
            ),
          ),
        ));
  }
}
