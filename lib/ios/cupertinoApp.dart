import 'package:flutter/cupertino.dart';

import 'package:shop_app/ios/screens/order_screen.dart';
import 'package:shop_app/ios/screens/product_detail_screen.dart';
import 'package:shop_app/ios/screens/products_overview.dart';
import 'package:shop_app/ios/screens/user_products_screen.dart';

class MyCupertinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
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
      ),
      routes: {},
    );
  }
}
