import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/screens/add_edit_product_screen.dart';
import 'package:shop_app/android/screens/auth_screen.dart';
import 'package:shop_app/android/screens/cart_screen.dart';
import 'package:shop_app/android/screens/orders_screen.dart';

import 'package:shop_app/android/screens/prodcut_detail_screen.dart';
import 'package:shop_app/android/screens/products_overview_screen.dart';
import 'package:shop_app/android/screens/user_products_screen.dart';
import 'package:shop_app/providers/auth.dart';

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) => MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: auth.isAuth
            ? MaterialProductsOverViewScreen()
            : MaterialAuthScreen(),
        routes: {
          MaterialProdcutDetailScreen.routeName: (ctx) =>
              MaterialProdcutDetailScreen(),
          MaterialCartScreen.routeName: (ctx) => MaterialCartScreen(),
          MaterialOrdersScreen.routeName: (ctx) => MaterialOrdersScreen(),
          MaterialUserProductsScreen.routeName: (ctx) =>
              MaterialUserProductsScreen(),
          MaterialAddEditProduct.routeName: (ctx) => MaterialAddEditProduct(),
        },
      ),
    );
  }
}
