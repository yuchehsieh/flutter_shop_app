import 'package:flutter/cupertino.dart';

class CupertinoAddEditProduct extends StatefulWidget {
  @override
  _CupertinoAddEditProductState createState() =>
      _CupertinoAddEditProductState();
}

class _CupertinoAddEditProductState extends State<CupertinoAddEditProduct> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Add Product'),
        trailing: CupertinoButton(
          child: Icon(
            CupertinoIcons.check_mark,
            size: 40,
          ),
          padding: const EdgeInsets.only(bottom: 20.0),
          onPressed: () {},
        ),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: Form(
            child: ListView(
              children: <Widget>[
                CupertinoTextField(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                  ),
                  // decoration: BoxDecoration(),
                  placeholder: 'Enter title',
                  textInputAction: TextInputAction.done,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
