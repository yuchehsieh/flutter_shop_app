import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ios/widgets/order_item.dart';
import 'package:shop_app/providers/orders.dart';

class CupertinoOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('My Order'),
      ),
      child: SafeArea(
          child: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (_, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator(radius: 10));
          } else {
            // if (dataSnapshot.error != null) {
            // ...
            // Do some error handling
            //
            // Error Handling down there
            // }
            return Consumer<Orders>(
              builder: (_, orderData, child) => CustomScrollView(
                slivers: <Widget>[
                  CupertinoSliverRefreshControl(
                    onRefresh: () => orderData.fetchAndSetOrders(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return (dataSnapshot.error != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    dataSnapshot.error.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'PULL TO REFRESH',
                                    style: TextStyle(
                                      color: CupertinoColors.activeGreen,
                                    ),
                                    // textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : CupertinoOrderItem(
                                orderData.orders[index],
                              );
                      },
                      childCount: (dataSnapshot.error != null)
                          ? 1
                          : orderData.orders.length,
                    ),
                  )
                ],
              ),
            );
          }
        },
      )),
    );
  }
}
