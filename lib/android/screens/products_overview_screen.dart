import 'package:flutter/material.dart';

import 'package:shop_app/android/widgets/products_grid.dart';

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
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: MaterialProductsGrid(_showOnlyFavorites),
    );
  }
}
