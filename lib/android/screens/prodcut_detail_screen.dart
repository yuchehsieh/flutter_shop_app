import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

enum FilterOptions {
  Favorites,
  All,
}

class MaterialProdcutDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context).settings.arguments;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false, // only get data one time
    ).findById(productId);
    final PreferredSizeWidget appBar = AppBar(
      title: Text(loadedProduct.title),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Hero(
                  tag: loadedProduct.id,
                  child: Image.network(
                    loadedProduct.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '\$${loadedProduct.price}',
                      style: const TextStyle(color: Colors.grey, fontSize: 20),
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
                    PopupMenuButton(
                      // onCanceled: ,
                      offset: Offset(-30, 50),
                      // enabled: false,
                      // elevation: 5,
                      // initialValue: FilterOptions.Favorites,
                      onSelected: (FilterOptions selectedValue) {
                        // setState(() {
                        //   if (selectedValue == FilterOptions.Favorites) {
                        //     _showOnlyFavorites = true;
                        //   } else {
                        //     _showOnlyFavorites = false;
                        //   }
                        // });
                      },
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          child: Text('Only Favorites'),
                          value: FilterOptions.Favorites,
                        ),
                        PopupMenuItem(
                          child: Text('Show All'),
                          value: FilterOptions.All,
                        ),
                      ],
                      icon: Icon(Icons.more_vert),
                    ),
                  ],
                ),
              )
              // AnimatedIcon(icon: AnimatedIcons.home_menu, progress: controller
            ],
          ),
        ),
      ),
    );
  }
}
