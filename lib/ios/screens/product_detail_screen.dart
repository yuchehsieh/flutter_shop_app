import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class CupertinoProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  final String productId;

  CupertinoProductDetailScreen(this.productId);

  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(loadedProduct.title),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Text(
                '\$${loadedProduct.price}',
                style: const TextStyle(
                    color: CupertinoColors.inactiveGray, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${loadedProduct.description}',
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
