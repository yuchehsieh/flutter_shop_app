import 'package:flutter/cupertino.dart';

import 'package:shop_app/ios/screens/order_screen.dart';
import 'package:shop_app/ios/screens/product_detail_screen.dart';
import 'package:shop_app/ios/screens/products_overview.dart';

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
              icon: Icon(CupertinoIcons.padlock_solid),
              title: Text('Cart'),
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
          }
        },
      ),
      routes: {},
    );
  }
}
