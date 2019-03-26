import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildEmailTextFormField(),
                      SizedBox(
                        height: 10.9,
                      ),
                      _buildPasswordTextFormField(),
                      buildAcceptSwitchListTile(),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        child: Text('Login'),
                        textColor: Colors.white,
                        onPressed: _submitForm,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  SwitchListTile buildAcceptSwitchListTile() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  TextFormField _buildPasswordTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Senha',
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Digita a senha rapaz';
        }
      },
      obscureText: true,
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  TextFormField _buildEmailTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E-mail',
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Digita um e-mail rapaz';
        }
      },
      keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }
}
