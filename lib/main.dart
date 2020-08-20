import 'package:blog_lite/AuthScreen/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'HomeScreen/home.dart';
import 'UsersScreen/users.dart';
import 'AuthScreen/auth_view.dart';

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
          UsersPage.routeName: (context) => UsersPage(),
          AuthView.routeName: (context) => AuthView(),
        },
        home: HomePage(title: '$blogName - Home Page'));
  }
}
