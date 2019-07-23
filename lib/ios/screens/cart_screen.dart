import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

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
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                // border: Border.all(width: 1),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black,
                    offset: Offset.infinite,
                    spreadRadius: 10,
                  ),
                ],
                color: CupertinoColors.lightBackgroundGray,
              ),
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
                    SizedBox(width: 10),
                    GestureDetector(
                      child: Text(
                        'Order Now',
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .actionTextStyle,
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
