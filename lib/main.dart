import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/screens/prodcut_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverViewScreen(),
        routes: {
          ProdcutDetailScreen.routeName: (ctx) => ProdcutDetailScreen(),
        },
      ),
    );
  }
}
