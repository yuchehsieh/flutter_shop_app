import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CupertinoAddEditProduct extends StatefulWidget {
  @override
  _CupertinoAddEditProductState createState() =>
      _CupertinoAddEditProductState();
}

class _CupertinoAddEditProductState extends State<CupertinoAddEditProduct> {
  final _priceFoucusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFoucusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

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
      child: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () =>
              // SystemChannels.textInput.invokeMethod('TextInput.hide'),
              FocusScope.of(context).unfocus(),
          onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
          child: Form(
            child: ListView(
              padding: EdgeInsets.only(bottom: 30),
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
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFoucusNode);
                  },
                ),
                CupertinoTextField(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                  ),
                  // decoration: BoxDecoration(),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  placeholder: 'Enter Price',
                  textInputAction: TextInputAction.done,
                  focusNode: _priceFoucusNode,
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                ),
                CupertinoTextField(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                  ),
                  // decoration: BoxDecoration(),
                  placeholder: 'description...',
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
