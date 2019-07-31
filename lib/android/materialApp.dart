import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/screens/add_edit_product_screen.dart';
import 'package:shop_app/android/screens/auth_screen.dart';
import 'package:shop_app/android/screens/cart_screen.dart';
import 'package:shop_app/android/screens/orders_screen.dart';

import 'package:shop_app/android/screens/prodcut_detail_screen.dart';
import 'package:shop_app/android/screens/products_overview_screen.dart';
import 'package:shop_app/android/screens/splash-screen.dart';
import 'package:shop_app/android/screens/user_products_screen.dart';
import 'package:shop_app/helpers/custom_route.dart';
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
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CustomRouteTransitionBuilder(),
              TargetPlatform.android: CustomRouteTransitionBuilder()
            },
          ),
          // textTheme: ThemeData.light().textTheme.copyWith(
          //       title: TextStyle(
          //         fontFamily: 'OpenSans',
          //         fontSize: 18,
          //         fontWeight: FontWeight.w400,
          //       ),
          //       button: TextStyle(color: Colors.white),
          //     ),
          // appBarTheme: AppBarTheme(
          //   textTheme: ThemeData.light().textTheme.copyWith(
          //         title: TextStyle(
          //           fontFamily: 'OpenSans',
          //           fontSize: 20,
          //         ),
          //       ),
          // ),
        ),
        home: auth.isAuth
            ? MaterialProductsOverViewScreen()
            : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (context, authResultSnapshot) =>
                    (authResultSnapshot.connectionState ==
                            ConnectionState.waiting)
                        ? MaterialSplashScreen()
                        : MaterialAuthScreen(),
                // when waiting is over
                // it'll automatically trigger notifierListener
                // thank to Consumer, will
              ),
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
