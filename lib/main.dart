import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

import './screens/tabs_screen.dart';
import './screens/UsersScreen/users_screen.dart';
import './screens/AuthScreen/auth_screen.dart';
import './screens/CategoriesScreen/categories_screen.dart';
import './screens/PostsScreen/posts_screen.dart';
import './screens/PostDetailScreen/post_detail_screen.dart';
import './screens/filters_screen.dart';
import './providers/auth.dart';
// import './counter_observer.dart';
import './dummy_data.dart';
import './models/post.dart';

//shop App
import './Shop/screens/products_overview_screen.dart';
import './Shop/screens/product_detail_screen.dart';
import './Shop/screens/card_screen.dart';
import './Shop/screens/orders_screen.dart';
import './Shop/screens/user_products_screen.dart';
import './Shop/screens/edit_product_screen.dart';
import './Shop/providers/products.dart';
import './Shop/providers/cart.dart';
import './Shop/providers/orders.dart';

// void main() {
//   // use only portrait mode ;)
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   // Bloc.observer = CounterObserver();
//   runApp(MyApp());
// }

void main() => runApp(ShopApp());

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Raleway',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'politics': false,
    'vegan': false,
    'fun': false,
    'vegetarian': false,
  };
  List<Post> _availablePosts = DUMMY_POSTS;
  List<Post> _favoritePosts = [];

  void _toggleFavorite(String postId) {
    final existingIndex = _favoritePosts.indexWhere(
      (el) => el.id == postId,
    );
    if (existingIndex >= 0) {
      setState(() {
        _favoritePosts.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritePosts.add(
          DUMMY_POSTS.firstWhere((el) => el.id == postId),
        );
      });
    }
  }

  bool _isFavorite(String id) {
    return _favoritePosts.any((el) => el.id == id);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availablePosts = DUMMY_POSTS.where((meal) {
        if (_filters['politics'] && !meal.isPolitics) {
          return false;
        }
        if (_filters['fun'] && !meal.isFun) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.amber,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                  body1: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  title: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
          // home: auth.isAuth ? UsersScreen() : AuthScreen(),
          // home: TabsScreen(),
          initialRoute: '/',
          routes: {
            '/': (ctx) => TabsScreen(_favoritePosts),
            UsersScreen.routeName: (ctx) => UsersScreen(),
            CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            PostsScreen.routeName: (ctx) => PostsScreen(_availablePosts),
            PostDetailScreen.routeName: (ctx) =>
                PostDetailScreen(_toggleFavorite, _isFavorite),
            FiltersScreen.routeName: (ctx) =>
                FiltersScreen(_filters, _setFilters),
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
                builder: (ctx) => TabsScreen(_favoritePosts));
          },
        ),
      ),
    );
  }
}
