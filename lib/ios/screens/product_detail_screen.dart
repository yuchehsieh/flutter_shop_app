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
        child: Center(
          child: Text('Detail'),
        ),
      ),
    );
  }
}
