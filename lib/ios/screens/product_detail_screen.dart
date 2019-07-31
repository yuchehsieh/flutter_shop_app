import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class CupertinoProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  final String productId;

  CupertinoProductDetailScreen(this.productId);

  @override
  _CupertinoProductDetailScreenState createState() =>
      _CupertinoProductDetailScreenState();
}

class _CupertinoProductDetailScreenState
    extends State<CupertinoProductDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;

  AnimationController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      );
      Timer(Duration(milliseconds: 165), _controller.forward);
      // _controller.forward();
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(widget.productId);

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
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        curve: Curves.easeIn,
                        parent: _controller,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '\$${loadedProduct.price}',
                          style: const TextStyle(
                              color: CupertinoColors.inactiveGray,
                              fontSize: 20),
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
