import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ios/widgets/user_product_item.dart';
import 'package:shop_app/providers/products.dart';

class CupertinoUserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Your Product'),
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.add),
          onPressed: () {},
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: productData.items.length,
              itemBuilder: (_, index) => Column(
                children: <Widget>[
                  CupertinoUserProductItem(
                    productData.items[index].title,
                    productData.items[index].imageUrl,
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
