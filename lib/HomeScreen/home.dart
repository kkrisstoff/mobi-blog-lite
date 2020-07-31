import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './counter/counter.dart';
import '../UsersScreen/users.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        centerTitle: true
      ),
      body: ShowUsersButton()
    );

    // return BlocProvider(
    //   create: (_) => CounterCubit(),
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text(this.title),
    //       centerTitle: true
    //     ),
    //     body: CounterView(),
    //     floatingActionButton: CounterAcrionButtons()
    //   )
    // );
   
  }
}

class ShowUsersButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: FloatingActionButton.extended(
        icon: const Icon(Icons.navigate_next),
        label: Text('Show Users'),
        onPressed: () {
          Navigator.pushNamed(
            context,
            UsersPage.routeName,
            arguments: ScreenArguments(
              'Users Screen',
              'Some sub-title',
            )
          );
        },
      )
    );
  }
}
