import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';

class CupertinoUserSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Setting'),
      ),
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              ListTile(
                leading: CupertinoButton(
                  child: Icon(CupertinoIcons.fullscreen_exit),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).logout();
                  },
                ),
                title: Text('Logout'),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
