import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CupertinoCartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  CupertinoCartItem({
    this.productId,
    this.title,
    this.quantity,
    this.price,
    this.id,
  });

  Future<bool> showAlertBeforeRemoveItem(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Are you sure to Delete'),
          content: Text('It won\'t recover, make sure to do this'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: false,
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Let me think!'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Delete'),
            )
          ],
        );
      },
    );
  }

  Future<bool> onConfirm(
    DismissDirection direction,
    BuildContext context,
  ) async {
    final bool isConfirmDeleted = await showAlertBeforeRemoveItem(context);
    if (isConfirmDeleted) {
      Provider.of<Cart>(context).removeItem(productId);
    }
    return isConfirmDeleted;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        child: Icon(
          CupertinoIcons.delete,
          color: CupertinoColors.white,
        ),
        color: CupertinoColors.destructiveRed,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      confirmDismiss: (direction) => onConfirm(direction, context),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
