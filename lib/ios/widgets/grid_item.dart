import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ios/screens/product_detail_screen.dart';
import 'package:shop_app/providers/product.dart';

class CupertinoProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (ctx) => CupertinoProductDetailScreen(product.id),
                ),
              );
            },
            child: Container(
                width: double.infinity,
                child: Image.network(product.imageUrl, fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: 30,
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.darkBackgroundGray.withOpacity(0.87),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CupertinoButton(
                    child: Icon(
                      product.isFavorite
                          ? CupertinoIcons.heart_solid
                          : CupertinoIcons.heart,
                    ),
                    onPressed: () => product.toggleFavoriteStatus(),
                    padding: EdgeInsets.only(bottom: 3),
                  ),
                  Text(
                    product.title,
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  CupertinoButton(
                    child: Icon(CupertinoIcons.shopping_cart),
                    onPressed: () {},
                    padding: EdgeInsets.only(bottom: 3),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
