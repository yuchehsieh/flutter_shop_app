import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoUserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  CupertinoUserProductItem(
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
            onPressed: () {},
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
