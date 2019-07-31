import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/ios/screens/add_edit_product_screen.dart';
import 'package:shop_app/providers/products.dart';

class CupertinoUserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  CupertinoUserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final snackBar = SnackBar(
      content: Text('Fail to delete item :('),
      behavior: SnackBarBehavior.floating,
    );
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CupertinoButton(
            child: Icon(
              CupertinoIcons.pen,
              // size: 20,
            ),
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (_) => CupertinoAddEditProduct(id)));
            },
          ),
          CupertinoButton(
            child: Icon(
              CupertinoIcons.delete,
              // size: 20,
              color: CupertinoColors.destructiveRed,
            ),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('Are you sure to Delete'),
                    content: Text('It won\'t recover, make sure to do this'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Let me think!'),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () async {
                          Navigator.of(context).pop();
                          try {
                            await Provider.of<Products>(context)
                                .deleteProduct(id);
                          } catch (e) {
                            scaffold.showSnackBar(snackBar);
                          }
                        },
                        child: Text('Delete'),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
