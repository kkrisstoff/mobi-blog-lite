import 'package:flutter/material.dart';

import './filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'text...',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildListTile(
            'Posts',
            Icons.restaurant_menu,
            () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          _buildListTile(
            'Filters',
            Icons.settings,
            () => Navigator.of(context)
                .pushReplacementNamed(FiltersScreen.routeName),
          ),
        ],
      ),
    );
  }
}
