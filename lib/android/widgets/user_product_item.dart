import 'package:flutter/material.dart';
import 'package:shop_app/android/screens/add_edit_product_screen.dart';

class MaterialUserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  MaterialUserProductItem(
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
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(
                MaterialAddEditProduct.routeName,
                arguments: id,
              );
            },
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
            color: Theme.of(context).errorColor,
          ),
        ],
      ),
    );
  }
}
