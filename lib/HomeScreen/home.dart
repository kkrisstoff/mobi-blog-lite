import 'package:flutter/material.dart';

import '../UsersScreen/users.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {  

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            // TODO: why it doesn't work?
            // FloatingActionButton.extended(
            //   icon: const Icon(Icons.navigate_next),
            //   label: Text('Show Users'),
            //   onPressed: () {
            //     Navigator.pushNamed(
            //       context,
            //       UsersPage.routeName,
            //       arguments: ScreenArguments(
            //         'Users Screen',
            //         'Some sub-title',
            //       )
            //     );
            //   },
            // ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  UsersPage.routeName,
                  arguments: ScreenArguments(
                    'Users Screen',
                    'Some sub-title',
                  )
                );
              },
              child: Hero(
                tag: 'imageHero',
                child: Center(child:
                  Row(
                    children: [
                      Text(
                        'Show Users',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Icon(Icons.navigate_next),
                    ]
                  ),
                )
              ),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
