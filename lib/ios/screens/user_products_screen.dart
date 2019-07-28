import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ios/screens/add_edit_product_screen.dart';
import 'package:shop_app/ios/widgets/user_product_item.dart';
import 'package:shop_app/providers/products.dart';

class CupertinoUserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _onRefreshProduct(BuildContext context) async {
    try {
      final response = await Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts();
      return response;
    } catch (e) {
      await showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: <Widget>[
            CupertinoDialogAction(
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
    final productData = Provider.of<Products>(context);

    return CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(
      //   middle: const Text('Your Product'),
      //   trailing: CupertinoButton(
      //     child: Icon(
      //       CupertinoIcons.add,
      //       size: 30,
      //     ),
      //     padding: const EdgeInsets.only(bottom: 5.0),
      //     onPressed: () {
      //       Navigator.of(context).push(
      //         CupertinoPageRoute(
      //           builder: (_) => CupertinoAddEditProduct(null),
      //         ),
      //       );
      //     },
      //   ),
      // ),

      child: SafeArea(
        top: false,
        child: Scaffold(
          body: CustomScrollView(
            // If left unspecified, the [CustomScrollView] appends an
            // [AlwaysScrollableScrollPhysics]. Behind the scene, the ScrollableState
            // will attach that [AlwaysScrollableScrollPhysics] to the output of
            // [ScrollConfiguration.of] which will be a [ClampingScrollPhysics]
            // on Android.
            // To demonstrate the iOS behavior in this demo and to ensure that the list
            // always scrolls, we specifically use a [BouncingScrollPhysics] combined
            // with a [AlwaysScrollableScrollPhysics]
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                automaticallyImplyTitle: false,
                largeTitle: const Text('Manage Product'),
                // We're specifying a back label here because the previous page
                // is a Material page. CupertinoPageRoutes could auto-populate
                // these back labels.
                previousPageTitle: 'Cupertino',
                // trailing: Text('Hi, Supervisor', style: TextStyle(fontSize: 14)),
              ),
              CupertinoSliverRefreshControl(
                onRefresh: () => _onRefreshProduct(context),
              ),
              SliverSafeArea(
                top: false, // Top safe area is consumed by the navigation bar.
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          CupertinoUserProductItem(
                            productData.items[index].id,
                            productData.items[index].title,
                            productData.items[index].imageUrl,
                          ),
                          Divider(),
                        ],
                      );
                    },
                    childCount: productData.items.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // child: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8),
      //     child: ListView.builder(
      //       itemCount: productData.items.length,
      //       itemBuilder: (_, index) => Column(
      //         children: <Widget>[
      //           CupertinoUserProductItem(
      //             productData.items[index].id,
      //             productData.items[index].title,
      //             productData.items[index].imageUrl,
      //           ),
      //           Divider(),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
