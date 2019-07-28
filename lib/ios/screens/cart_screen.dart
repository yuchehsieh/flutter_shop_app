import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ios/widgets/cart_item.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';

class CupertinoCartScreen extends StatelessWidget {
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
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
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
                    OrderButton(cart: cart),
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
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: CupertinoColors.activeBlue,
              child: Center(
                child:
                    OrderButton(cart: cart, textColor: CupertinoColors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final cart;
  final Color textColor;

  const OrderButton({
    Key key,
    this.textColor = CupertinoColors.activeBlue,
    @required this.cart,
  }) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  Future<bool> _showConfirmBeforeMakeOrder(BuildContext context) {
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

  void _showSuccess(BuildContext context) {
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

  void _showAlertWithError(String error) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Error'),
          content: Text(error),
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

  void _onConfirmOrder(Cart cart, BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final bool isConfirmOrder = await _showConfirmBeforeMakeOrder(context);
    if (isConfirmOrder) {
      try {
        await Provider.of<Orders>(context).addOrder(
          cart.items.values.toList(),
          cart.totalAmount,
        );
        setState(() {
          _isLoading = false;
        });
        widget.cart.clear();
        Timer(Duration(seconds: 1), () {
          cart.clear();
          _showSuccess(context);
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showAlertWithError(e.toString());
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: _isLoading
          ? const CupertinoActivityIndicator(radius: 7)
          : Text(
              'ORDER NOW',
              style: TextStyle(color: widget.textColor),
            ),
      onPressed: (widget.cart.items.length <= 0 || _isLoading)
          ? null
          : () => _onConfirmOrder(widget.cart, context),
    );
  }
}
