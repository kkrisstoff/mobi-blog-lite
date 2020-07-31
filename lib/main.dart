import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'HomeScreen/home.dart';
import 'UsersScreen/users.dart';
import 'counter_observer.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(MyApp());
}

final String blogName = 'Tasty blog';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // HomePage.routeName: (context) => HomePage(title: '$blogName - Home Page'),
        UsersPage.routeName: (context) => UsersPage(),
      },
      home: HomePage(title: '$blogName - Home Page')

    );
  }
}