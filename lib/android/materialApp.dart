import 'package:flutter/material.dart';
import 'package:shop_app/android/screens/cart_screen.dart';
import 'package:shop_app/android/screens/orders_screen.dart';

import 'package:shop_app/android/screens/prodcut_detail_screen.dart';
import 'package:shop_app/android/screens/products_overview_screen.dart';
import 'package:shop_app/android/screens/user_products_screen.dart';

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: MaterialProductsOverViewScreen(),
      routes: {
        MaterialProdcutDetailScreen.routeName: (ctx) =>
            MaterialProdcutDetailScreen(),
        MaterialCartScreen.routeName: (ctx) => MaterialCartScreen(),
        MaterialOrdersScreen.routeName: (ctx) => MaterialOrdersScreen(),
        MaterialUserProductsScreen.routeName: (ctx) =>
            MaterialUserProductsScreen(),
      },
    );
  }
}
