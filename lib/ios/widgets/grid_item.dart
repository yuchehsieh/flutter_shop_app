import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ios/screens/product_detail_screen.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';

class CupertinoProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
          cart.removeSingleItem(product.id);
        },
        textColor: CupertinoColors.destructiveRed,
      ),
      behavior: SnackBarBehavior.floating,
      // duration: Duration(seconds: 2),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (ctx) => CupertinoProductDetailScreen(product.id),
                ),
              );
            },
            child: Container(
                width: double.infinity,
                child: Image.network(product.imageUrl, fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: 30,
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.darkBackgroundGray.withOpacity(0.87),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Consumer<Product>(
                    builder: (context, product, child) => CupertinoButton(
                      child: Icon(
                        product.isFavorite
                            ? CupertinoIcons.heart_solid
                            : CupertinoIcons.heart,
                      ),
                      onPressed: () =>
                          product.toggleFavoriteStatus(authData.token),
                      padding: EdgeInsets.only(bottom: 3),
                    ),
                    child: Text('this part is never change'),
                  ),
                  Text(
                    product.title,
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  CupertinoButton(
                    child: Icon(CupertinoIcons.shopping_cart),
                    onPressed: () {
                      cart.addItem(
                        product.id,
                        product.price,
                        product.title,
                      );

                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    padding: EdgeInsets.only(bottom: 3),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
