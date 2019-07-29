import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/screens/add_edit_product_screen.dart';
import 'package:shop_app/android/widgets/app_drawer.dart';
import 'package:shop_app/android/widgets/user_product_item.dart';
import 'package:shop_app/providers/products.dart';

class MaterialUserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _onRefreshProduct(BuildContext context) async {
    try {
      final response = await Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts(true);
      return response;
    } catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
      return Future.value();
    }

    // TEACHER'S APPROACH
    // await Provider.of<Products>(context, listen: false)
    //     .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(MaterialAddEditProduct.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Products>(context, listen: false)
            .fetchAndSetProducts(true),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<Products>(
              builder: (_, productData, child) => RefreshIndicator(
                onRefresh: () => _onRefreshProduct(context),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: (dataSnapshot.error != null)
                      ? Center(
                          child: Text(
                            'Error to loaded data, drag to refresh later',
                          ),
                        )
                      : ListView.builder(
                          itemCount: productData.items.length,
                          itemBuilder: (_, index) => Column(
                            children: <Widget>[
                              MaterialUserProductItem(
                                productData.items[index].id,
                                productData.items[index].title,
                                productData.items[index].imageUrl,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
