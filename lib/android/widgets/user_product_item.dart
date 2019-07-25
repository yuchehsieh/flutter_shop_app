import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/screens/add_edit_product_screen.dart';
import 'package:shop_app/providers/products.dart';

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
            onPressed: () {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Are you sure to delete'),
                  content: Text('Do you want to remove item from the cart'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Provider.of<Products>(context, listen: false)
                            .deleteProduct(id);
                      },
                    ),
                  ],
                ),
              );
            },
            color: Theme.of(context).errorColor,
          ),
        ],
      ),
    );
  }
}
