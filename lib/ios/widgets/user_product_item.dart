import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/ios/screens/add_edit_product_screen.dart';

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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
