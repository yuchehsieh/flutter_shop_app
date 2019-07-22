import 'package:flutter/cupertino.dart';

class CupertinoProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  final String title;

  CupertinoProductDetailScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: SafeArea(
        child: Center(
          child: Text('Detail'),
        ),
      ),
    );
  }
}
