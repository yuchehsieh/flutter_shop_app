import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/screens/orders_screen.dart';
import 'package:shop_app/android/screens/user_products_screen.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello, Friend'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text('Orders'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  CustomSlideRoute(
                    builder: (ctx) => MaterialOrdersScreen(),
                  ),
                );
                // Navigator.of(context)
                //     .pushReplacementNamed(MaterialOrdersScreen.routeName);
              }),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(MaterialUserProductsScreen.routeName),
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context)
                    .pushReplacementNamed('/'); // always back to home route
                Provider.of<Auth>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
