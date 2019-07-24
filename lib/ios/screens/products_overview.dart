import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/screens/products_overview_screen.dart';
import 'package:shop_app/android/widgets/badge.dart';
import 'package:shop_app/ios/screens/cart_screen.dart';
import 'package:shop_app/ios/widgets/products_grid.dart';
import 'package:shop_app/providers/cart.dart';

enum FiltersOptions { Favorites, All, Cancel }

class CupertinoProductsOverviewScreen extends StatefulWidget {
  @override
  _CupertinoProductsOverviewScreenState createState() =>
      _CupertinoProductsOverviewScreenState();
}

class _CupertinoProductsOverviewScreenState
    extends State<CupertinoProductsOverviewScreen> {
  bool _showOnlyFavorite = false;

  Future<FiltersOptions> _showCupertinoActionSheet(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text(
            'Select your Filter',
            // style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
          ),
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel!!'),
            onPressed: () {
              Navigator.of(context).pop(FiltersOptions.Cancel);
            },
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('Filter Only Favorites'),
              onPressed: () {
                Navigator.of(context).pop(FiltersOptions.Favorites);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Filter All'),
              onPressed: () {
                Navigator.of(context).pop(FiltersOptions.All);
              },
            ),
          ],
        );
      },
    );
  }

  void _setFilterOptions(context) async {
    final FiltersOptions selectedValue =
        await _showCupertinoActionSheet(context);
    setState(() {
      if (selectedValue == FiltersOptions.Favorites) {
        _showOnlyFavorite = true;
      }
      if (selectedValue == FiltersOptions.All) {
        _showOnlyFavorite = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('MyShop'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Consumer<Cart>(
              builder: (_, cartData, child) => Badge(
                color: CupertinoColors.activeBlue,
                value: cartData.itemCount.toString(),
                child: child,
              ),
              child: CupertinoButton(
                child: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (_) => CupertinoCartScreen()),
                  );
                },
              ),
            ),
            CupertinoButton(
              child: Icon(Icons.more_vert),
              onPressed: () => _setFilterOptions(context),
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(body: CupertinoProductGrid(_showOnlyFavorite)),
      ),
    );
  }
}
