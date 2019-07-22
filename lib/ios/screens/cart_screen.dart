import 'package:flutter/cupertino.dart';

class CupertinoCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('MyShop'),
      ),
      child: SafeArea(
        child: Center(
          child: Text('Cart'),
        ),
      ),
    );
  }
}
