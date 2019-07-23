import 'package:flutter/cupertino.dart';

class CupertinoOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('My Order'),
      ),
      child: SafeArea(
        child: Center(
          child: Text('Order'),
        ),
      ),
    );
  }
}