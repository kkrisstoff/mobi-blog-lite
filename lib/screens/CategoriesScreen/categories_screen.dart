import 'package:flutter/material.dart';

import './category_item.dart';
import '../../dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/categories';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(12),
      children: DUMMY_CATEGORIES
          .map((catData) => CategoryItem(
                catData.id,
                catData.title,
                catData.color,
              ))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
    );
  }
}
