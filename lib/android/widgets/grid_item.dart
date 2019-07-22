import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/screens/prodcut_detail_screen.dart';
import 'package:shop_app/providers/product.dart';

class MaterialProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // MaterialProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              MaterialProdcutDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite_border : Icons.favorite,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => product.toggleFavoriteStatus(),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
