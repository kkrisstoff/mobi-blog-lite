import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

import './screens/HomeScreen/home.dart';
import 'UsersScreen/users.dart';
import 'screens/AuthScreen/auth_screen.dart';

import 'counter_observer.dart';

void main() {
  // use only portrait mode ;)
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Bloc.observer = CounterObserver();
  runApp(MyApp());
}

final String blogName = 'Tasty blog';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                ),
              ),
        ),
        routes: {
          UsersPage.routeName: (context) => UsersPage(),
          AuthScreen.routeName: (context) => AuthScreen(),
        },
        home: HomePage(title: '$blogName - Home Page'));
  }
}
