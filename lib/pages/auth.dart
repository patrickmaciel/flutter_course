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

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.5),
        BlendMode.dstATop,
      ),
      image: AssetImage('assets/background.jpg'),
      // image: Image.asset('assets/background.jpg'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        MediaQuery.of(context).size.width > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Container(
          decoration: BoxDecoration(
            image: _buildBackgroundImage(),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: targetWidth,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.9,
                    ),
                    _buildPasswordTextField(),
                    buildAcceptSwitchListTile(),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      child: Text('Login'),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      onPressed: _submitForm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _submitForm() {
    print(_inputEmail);
    print(_inputPassword);
    Navigator.pushReplacementNamed(context, '/products');
  }

  SwitchListTile buildAcceptSwitchListTile() {
    return SwitchListTile(
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
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
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
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
    );
  }
}
