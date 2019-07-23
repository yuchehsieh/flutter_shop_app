import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/ios/widgets/grid_item.dart';
import 'package:shop_app/providers/products.dart';

class CupertinoProductGrid extends StatelessWidget {
  final bool showOnlyFav;

  CupertinoProductGrid(this.showOnlyFav);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products =
        showOnlyFav ? productData.favoriteItems : productData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: CupertinoProductItem(),
        );
      },
    );
  }
}
