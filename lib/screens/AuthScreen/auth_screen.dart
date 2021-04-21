import 'dart:math';

import 'package:flutter/material.dart';
import 'auth.dart';
import '../../api/repository.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Auth View'), centerTitle: true),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.all(10),
                        child: Image.asset('assets/fonts/images/user.png'),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthForm(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key key,
  }) : super(key: key);

  @override
  _AuthFormState createState() {
    return _AuthFormState();
  }
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;

  final _passwordController = TextEditingController();
  final usernameController = TextEditingController();

  final UserRepository _repository = RestRepository();

  void _submit() {
    // current
    // if (_formKey.currentState.validate()) {
    //   _formKey.currentState.save();
    // }

    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // Log user in
    } else {
      // Sign user up
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        // height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter your username'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter User Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value;
                },
                // controller: usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter password'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                obscureText: true,
                onSaved: (value) {
                  _authData['password'] = value;
                },
                controller: _passwordController,
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  enabled: _authMode == AuthMode.Signup,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: _authMode == AuthMode.Signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                          return null;
                        }
                      : null,
                ),
              SizedBox(
                height: 20,
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                RaisedButton(
                  child:
                      Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  onPressed: _submit,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                ),
              FlatButton(
                child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                onPressed: _switchAuthMode,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).primaryColor,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
