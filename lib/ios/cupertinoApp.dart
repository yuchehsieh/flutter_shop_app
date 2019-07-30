import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/screens/auth_screen.dart';
import 'package:shop_app/android/screens/splash-screen.dart';

import 'package:shop_app/ios/screens/order_screen.dart';
import 'package:shop_app/ios/screens/product_detail_screen.dart';
import 'package:shop_app/ios/screens/products_overview.dart';
import 'package:shop_app/ios/screens/user_products_screen.dart';
import 'package:shop_app/providers/auth.dart';

class MyCupertinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, _) => CupertinoApp(
        home: auth.isAuth
            ? MyCupertinoTabScaffold()
            : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (context, authResultSnapshor) =>
                    authResultSnapshor.connectionState ==
                            ConnectionState.waiting
                        ? MaterialSplashScreen()
                        : MaterialAuthScreen(),
              ),

        // CupertinoTabScaffold(
        //   tabBar: CupertinoTabBar(
        //     items: [
        //       BottomNavigationBarItem(
        //         icon: Icon(CupertinoIcons.home),
        //         title: Text('Shop'),
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(CupertinoIcons.paw),
        //         title: Text('Orders'),
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(CupertinoIcons.pen),
        //         title: Text('Manage'),
        //       )
        //     ],
        //   ),
        //   tabBuilder: (context, index) {
        //     switch (index) {
        //       case 0:
        //         return CupertinoTabView(builder: (context) {
        //           return CupertinoProductsOverviewScreen();
        //         });
        //       case 1:
        //         return CupertinoTabView(builder: (context) {
        //           return CupertinoOrderScreen();
        //         });
        //       case 2:
        //         return CupertinoTabView(builder: (context) {
        //           return CupertinoUserProductsScreen();
        //         });
        //     }
        //   },
        // ),
        routes: {},
      ),
    );
  }
}

class MyCupertinoTabScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('Shop'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.paw),
            title: Text('Orders'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.pen),
            title: Text('Manage'),
          )
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoProductsOverviewScreen();
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoOrderScreen();
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoUserProductsScreen();
            });
        }
      },
    );
  }
}
