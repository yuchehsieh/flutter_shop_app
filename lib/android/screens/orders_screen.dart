import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/widgets/app_drawer.dart';
import 'package:shop_app/android/widgets/order_item.dart';
import 'package:shop_app/providers/orders.dart';

class MaterialOrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => MaterialOrderItem(
          orderData.orders[index],
        ),
      ),
    );
  }
}
