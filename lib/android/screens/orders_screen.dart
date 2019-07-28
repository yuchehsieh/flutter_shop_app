import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/android/widgets/app_drawer.dart';
import 'package:shop_app/android/widgets/order_item.dart';
import 'package:shop_app/providers/orders.dart';

class MaterialOrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _MaterialOrdersScreenState createState() => _MaterialOrdersScreenState();
}

class _MaterialOrdersScreenState extends State<MaterialOrdersScreen> {
  bool _isLoading = false;

  /* Using different approach */
  /*
   * With (listen: false), 
   * could ignore the Future.delayed(Duration.zero)
   */
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  // bool _isInit = true;
  // @override
  // void didChangeDependencies() {
  //   if(_isInit) {
  //     Provider.of<Orders>(context).fetchAndSetOrders().then(() {
  //       ///
  //     });

  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (context, index) => MaterialOrderItem(
                orderData.orders[index],
              ),
            ),
    );
  }
}
