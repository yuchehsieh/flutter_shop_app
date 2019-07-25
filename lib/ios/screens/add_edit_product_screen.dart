import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/providers/product.dart';

class CupertinoAddEditProduct extends StatefulWidget {
  @override
  _CupertinoAddEditProductState createState() =>
      _CupertinoAddEditProductState();
}

class _CupertinoAddEditProductState extends State<CupertinoAddEditProduct> {
  /* FocusNode */
  final _titleFocusNode = FocusNode();
  final _priceFoucusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  /* Controller */
  final _imageUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  /* GlobalKey<FormState> */
  final _form = GlobalKey<FormState>();

  Product _editedProduct = Product(
    price: null,
    imageUrl: null,
    id: null,
    title: null,
    description: null,
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
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

  void _saveForm() {
    _form.currentState.save();
    _editedProduct = Product(
      description: _descriptionController.text,
      title: _titleController.text,
      id: _editedProduct.id,
      imageUrl: _imageUrlController.text,
      price: double.parse(_priceController.text),
    );
    print(_titleController.text);
    print(_priceController.text);
    print(_descriptionController.text);
    print(_imageUrlController.text);
  }

  @override
  Widget build(BuildContext context) {
    final fieldPadding = const EdgeInsets.only(
      top: 20.0,
      left: 15.0,
      right: 15.0,
      bottom: 10.0,
    );

    final fieldDecoration = const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray),
      ),
    );

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Add Product'),
        trailing: CupertinoButton(
          child: Icon(
            CupertinoIcons.check_mark,
            size: 40,
          ),
          padding: const EdgeInsets.only(bottom: 20.0),
          onPressed: _saveForm,
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
            key: _form,
            child: ListView(
              padding: EdgeInsets.only(bottom: 30),
              children: <Widget>[
                CupertinoTextField(
                  prefix: Padding(
                    padding: fieldPadding,
                    child: Icon(
                      CupertinoIcons.person_solid,
                      color: _titleFocusNode.hasFocus
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.lightBackgroundGray,
                      size: 28.0,
                    ),
                  ),
                  focusNode: _titleFocusNode,
                  padding: fieldPadding,
                  clearButtonMode: _titleFocusNode.hasFocus
                      ? OverlayVisibilityMode.editing
                      : OverlayVisibilityMode.never,
                  textCapitalization: TextCapitalization.words,
                  autocorrect: false,
                  decoration: fieldDecoration,
                  placeholder: 'Name',
                  controller: _titleController,
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFoucusNode);
                  },
                ),
                CupertinoTextField(
                  prefix: Padding(
                    padding: fieldPadding,
                    child: Icon(
                      CupertinoIcons.tag,
                      color: _priceFoucusNode.hasFocus
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.lightBackgroundGray,
                      size: 28.0,
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  padding: fieldPadding,
                  decoration: fieldDecoration,
                  clearButtonMode: _priceFoucusNode.hasFocus
                      ? OverlayVisibilityMode.editing
                      : OverlayVisibilityMode.never,
                  placeholder: 'Enter Price',
                  textInputAction: TextInputAction.done,
                  focusNode: _priceFoucusNode,
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  controller: _priceController,
                ),
                CupertinoTextField(
                  prefix: Padding(
                    padding: fieldPadding,
                    child: Icon(
                      CupertinoIcons.right_chevron,
                      color: _descriptionFocusNode.hasFocus
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.lightBackgroundGray,
                      size: 28.0,
                    ),
                  ),
                  padding: fieldPadding,
                  decoration: fieldDecoration,
                  clearButtonMode: _descriptionFocusNode.hasFocus
                      ? OverlayVisibilityMode.editing
                      : OverlayVisibilityMode.never,
                  placeholder: 'description...',
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  controller: _descriptionController,
                ),
                Padding(
                  padding: fieldPadding,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: _imageUrlFocusNode.hasFocus
                                  ? CupertinoColors.activeBlue
                                  : CupertinoColors.inactiveGray),
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
                          decoration: fieldDecoration,
                          placeholder: 'Enter image url ...',
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          clearButtonMode: _imageUrlFocusNode.hasFocus
                              ? OverlayVisibilityMode.editing
                              : OverlayVisibilityMode.never,
                          focusNode: _imageUrlFocusNode,
                          controller: _imageUrlController,
                          onSubmitted: (_) => _saveForm(),
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
