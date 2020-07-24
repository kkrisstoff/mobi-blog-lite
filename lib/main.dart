import 'package:flutter/material.dart';

import 'HomeScreen/home.dart';
import 'UsersScreen/users.dart';

void main() => runApp(MyApp());

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