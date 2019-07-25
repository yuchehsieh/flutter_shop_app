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
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _priceFoucusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: CupertinoColors.inactiveGray),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? Text(
                                'Enter a URL',
                                style: TextStyle(
                                    color: CupertinoColors.inactiveGray),
                              )
                            : FittedBox(
                                child: Image.network(_imageUrlController.text),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: CupertinoTextField(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            left: 10.0,
                            right: 0.0,
                            bottom: 5.0,
                          ),
                          placeholder: 'Enter image url ...',
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          focusNode: _imageUrlFocusNode,
                          controller: _imageUrlController,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
