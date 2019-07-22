import 'package:flutter/cupertino.dart';
import 'package:shop_app/ios/widgets/products_grid.dart';

class CupertinoProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('MyShop'),
      ),
      child: SafeArea(
        child: CupertinoProductGrid(),
      ),
    );
  }
}
