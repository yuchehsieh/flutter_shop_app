import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/android/materialApp.dart';
import 'package:shop_app/ios/cupertinoApp.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bool isIOS = Platform.isIOS;

    return ChangeNotifierProvider(
      builder: (ctx) => Products(),
      child: isIOS ? MyCupertinoApp() : MyMaterialApp(),
      // child: MyMaterialApp(),
    );
  }
}
