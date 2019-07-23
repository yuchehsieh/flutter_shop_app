import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ios/widgets/cart_item.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';

class CupertinoCartScreen extends StatelessWidget {
  Future<bool> showConfirmBeforeMakeOrder(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Add all cart items to order ?'),
          // content: Text('It won\'t recover, make sure to do this'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Let me think'),
            )
          ],
        );
      },
    );
  }

  void showSuccess(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Success'),
          // content: Text('It won\'t recover, make sure to do this'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void onConfirmOrder(Cart cart, BuildContext context) async {
    final bool isConfirmOrder = await showConfirmBeforeMakeOrder(context);
    if (isConfirmOrder) {
      Provider.of<Orders>(context).addOrder(
        cart.items.values.toList(),
        cart.totalAmount,
      );
    }
    Timer(Duration(seconds: 1), () {
      cart.clear();
      showSuccess(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Your Cart'),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Text(
                        '\$${cart.totalAmount}',
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                    CupertinoButton(
                      child: Text(
                        'ORDER NOW',
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .actionTextStyle,
                      ),
                      onPressed: () {
                        onConfirmOrder(cart, context);
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (context, index) => CupertinoCartItem(
                  id: cart.items.values.toList()[index].id,
                  price: cart.items.values.toList()[index].price,
                  quantity: cart.items.values.toList()[index].quantity,
                  title: cart.items.values.toList()[index].title,
                  productId: cart.items.keys.toList()[index],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
