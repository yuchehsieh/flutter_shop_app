import 'package:flutter/material.dart';
import 'package:shop_app/android/screens/prodcut_detail_screen.dart';

class MaterialProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  MaterialProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              MaterialProdcutDetailScreen.routeName,
              arguments: id,
            );
          },
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
