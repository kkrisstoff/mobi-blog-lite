import 'package:flutter/material.dart';
import './auth.dart';
import '../api/repository.dart';

class AuthView extends StatelessWidget {
  static const routeName = '/auth';

  AuthView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Auth View'), centerTitle: true),
        body: AuthForm());
  }
}

class AuthForm extends StatefulWidget {
  @override
  AuthFormState createState() {
    return AuthFormState();
  }
}

class AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  final UserRepository _repository = RestRepository();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Text('User Name'),
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter your username'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter User Name';
              }
              return null;
            },
            controller: usernameController,
          ),
          Text('Password'),
          TextFormField(
              decoration: InputDecoration(labelText: 'Enter password'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              controller: passwordController),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  this.handleForm(context, usernameController.text,
                      passwordController.text);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ]));
  }

  handleForm(BuildContext context, username, password) async {
    final LoggedUser currentUser = await _repository.login(username, password);
    if (currentUser == null) {
      return Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')));
    }

    print('>>>');
    print(currentUser.token);
    // Navigator.pushNamed(context, UsersPage.routeName,
    //     arguments: ScreenArguments(
    //       'Users Screen',
    //       'Some sub-title',
    //     ));
  }
}
