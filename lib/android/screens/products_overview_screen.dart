import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/screens/cart_screen.dart';
import 'package:shop_app/android/screens/orders_screen.dart';
import 'package:shop_app/android/widgets/app_drawer.dart';
import 'package:shop_app/android/widgets/badge.dart';

import 'package:shop_app/android/widgets/products_grid.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';

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
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void initState() {
    /* WON'T WORK 
      Provider.of<Products>(context).fetchAndSetProducts();
    */

    /* SOME HACK MAY WORK 
      Future.delayed(Duration.zero).then(() {
        Provider.of<Products>(context).fetchAndSetProducts(); 
      })
    */

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

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
              onPressed: () {
                Navigator.of(context).pushNamed(MaterialCartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : MaterialProductsGrid(_showOnlyFavorites),
    );
  }
}
