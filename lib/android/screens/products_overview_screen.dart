import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/widgets/badge.dart';

import 'package:shop_app/android/widgets/products_grid.dart';
import 'package:shop_app/providers/cart.dart';

enum FilterOptions {
  Favorites,
  All,
}

class MaterialProductsOverViewScreen extends StatefulWidget {
  @override
  _MaterialProductsOverViewScreenState createState() =>
      _MaterialProductsOverViewScreenState();
}

class _MaterialProductsOverViewScreenState
    extends State<MaterialProductsOverViewScreen> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              value: cart.itemCount.toString(),
              color: Colors.amberAccent,
              child: child,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: MaterialProductsGrid(_showOnlyFavorites),
    );
  }
}
