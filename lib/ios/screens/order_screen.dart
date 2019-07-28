import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ios/widgets/order_item.dart';
import 'package:shop_app/providers/orders.dart';

class CupertinoOrderScreen extends StatefulWidget {
  @override
  _CupertinoOrderScreenState createState() => _CupertinoOrderScreenState();
}

class _CupertinoOrderScreenState extends State<CupertinoOrderScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('My Order'),
      ),
      child: SafeArea(
        child: _isLoading
            ? Center(child: CupertinoActivityIndicator(radius: 10))
            : CustomScrollView(
                slivers: <Widget>[
                  CupertinoSliverRefreshControl(
                    onRefresh: () => orderData.fetchAndSetOrders(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return CupertinoOrderItem(
                        orderData.orders[index],
                      );
                    }, childCount: orderData.orders.length),
                  )
                ],
              ),
      ),
    );
  }
}
