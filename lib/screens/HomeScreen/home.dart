import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './counter/counter.dart';
import '../UsersScreen/users_screen.dart';
import '../AuthScreen/auth_screen.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.widget.title),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[ShowUsersButton(), LogOutsButton()],
        ));

    return BlocProvider(
        create: (_) => CounterCubit(),
        child: Scaffold(
            appBar: AppBar(title: Text(this.widget.title), centerTitle: true),
            body: CounterView(),
            floatingActionButton: CounterAcrionButtons()));
  }
}

class ShowUsersButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FloatingActionButton.extended(
      icon: const Icon(Icons.navigate_next),
      label: Text('Show Users'),
      onPressed: () {
        Navigator.pushNamed(context, UsersScreen.routeName,
            arguments: ScreenArguments(
              'Users Screen',
              'Some sub-title',
            ));
      },
    ));
  }
}

class LogOutsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FloatingActionButton.extended(
      icon: const Icon(Icons.navigate_next),
      label: Text('Log Out Users'),
      onPressed: () {
        Navigator.pushNamed(context, AuthScreen.routeName,
            arguments: ScreenArguments(
              'Users Screen',
              'Some sub-title',
            ));
      },
    ));
  }
}
