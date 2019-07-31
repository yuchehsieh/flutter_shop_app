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
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text(loadedProduct.title),
      // ),
      child: CustomScrollView(
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
            // automaticallyImplyTitle: true,
            // middle: Text('Detail Screen'),
            largeTitle: Text('Detail Screen'),
            previousPageTitle: 'My Shop',
            trailing: Text('Hi, Supervisor', style: TextStyle(fontSize: 14)),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () {
              return Future.delayed(Duration(seconds: 2)).then((_) {
                return Future.value();
              });
            },
          ),
          SliverSafeArea(
            top: false, // Top safe area is consumed by the navigation bar.
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
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
        ],
      ),
      // child: SafeArea(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: <Widget>[
      //         Container(
      //           height: 300,
      //           width: double.infinity,
      //           child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
      //         ),
      //         const SizedBox(height: 10),
      //         Text(
      //           '\$${loadedProduct.price}',
      //           style: const TextStyle(
      //               color: CupertinoColors.inactiveGray, fontSize: 20),
      //         ),
      //         const SizedBox(height: 10),
      //         Container(
      //           width: double.infinity,
      //           padding: const EdgeInsets.symmetric(horizontal: 10),
      //           child: Text(
      //             '${loadedProduct.description}',
      //             textAlign: TextAlign.center,
      //             softWrap: true,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
