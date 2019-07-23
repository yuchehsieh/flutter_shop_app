import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ios/widgets/order_item.dart';
import 'package:shop_app/providers/orders.dart';

class CupertinoOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('My Order'),
      ),
      child: SafeArea(
          child: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => CupertinoOrderItem(
          orderData.orders[index],
        ),
      )),
    );
  }
}
