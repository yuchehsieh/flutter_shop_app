import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/widgets/app_drawer.dart';
import 'package:shop_app/android/widgets/order_item.dart';
import 'package:shop_app/providers/orders.dart';

class MaterialOrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    /*
      // final orderData = Provider.of<Orders>(context);
      If don't comment this out,
      when FutureBuilder done, it'll triger re-build
      and re-build will trigger FutureBuilder ...

      So Avoid the inifinte-loop,
      Simply wrap Widget with Consumer!
    */
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Order'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                // ...
                // Do some error handling
                return Text('An Error Occured');
              } else {
                return Consumer<Orders>(
                  builder: (context, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (context, index) => MaterialOrderItem(
                      orderData.orders[index],
                    ),
                  ),
                );
              }
            }
          },
        ));
  }
}
