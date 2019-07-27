import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class CupertinoAddEditProduct extends StatefulWidget {
  final productId;

  CupertinoAddEditProduct(this.productId);

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

  bool _isInit = true;
  bool _isLoading = false;

  Product _editedProduct = Product(
    price: null,
    imageUrl: null,
    id: null,
    title: null,
    description: null,
  );

  // can't assign initValue
  // using controller instead

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit && widget.productId != null) {
      _editedProduct =
          Provider.of<Products>(context).findById(widget.productId);
      _imageUrlController.text = _editedProduct.imageUrl;
      _titleController.text = _editedProduct.title;
      _priceController.text = _editedProduct.price.toString();
      _descriptionController.text = _editedProduct.description;
    }

    _isInit = false;
    super.didChangeDependencies();
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
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }

      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    setState(() {
      _isLoading = true;
    });

    /* all String */
    final title = _titleController.text;
    final price = _priceController.text;
    final imageUrl = _imageUrlController.text;
    final description = _descriptionController.text;

    /* validate */
    final titleValidation = _titleValidator(title);
    final priceValidation = _priceValidator(price);
    final imageUrlValidation = _imageUrlValidator(imageUrl);
    final descriptionValidation = _descriptionValidator(description);

    List<String> errorMessage = [];

    if (titleValidation != null) {
      errorMessage.add(titleValidation);
    }
    if (priceValidation != null) {
      errorMessage.add(priceValidation);
    }
    if (imageUrlValidation != null) {
      errorMessage.add(imageUrlValidation);
    }
    if (descriptionValidation != null) {
      errorMessage.add(imageUrlValidation);
    }

    if (errorMessage.length != 0) {
      _showErrorMessage(errorMessage);
      return;
    }

    /* save */
    _form.currentState.save();
    _editedProduct = Product(
      description: _descriptionController.text,
      title: _titleController.text,
      id: _editedProduct.id,
      imageUrl: _imageUrlController.text,
      isFavorite: _editedProduct.isFavorite,
      price: double.parse(_priceController.text),
    );

    if (widget.productId != null) {
      try {
        await Provider.of<Products>(context)
            .upadteProduct(_editedProduct.id, _editedProduct);
      } catch (e) {
        await _showAlertWithError(e.toString());
      }
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (e) {
        await _showAlertWithError(e.toString());
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showAlertWithError(String e) {
    return showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text('Error'),
        content: Text(e),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _showErrorMessage(List<String> errorMessage) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Some input error!'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: errorMessage.map((message) => Text(message)).toList(),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  dynamic _titleValidator(String value) {
    if (value.isEmpty) {
      return 'Please Enter a title';
    }
    return null;
  }

  dynamic _priceValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a price';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (double.parse(value) <= 0) {
      return 'Please a number greater than zero';
    }
    return null;
  }

  dynamic _imageUrlValidator(String value) {
    if (value.isEmpty) {
      return 'Please Enter an image URL';
    }
    if (!value.startsWith('http') || !value.startsWith('https')) {
      return 'Pleas a valid image URL start';
    }
    if (!value.endsWith('.png') &&
        !value.endsWith('.jpg') &&
        !value.endsWith('.jpeg')) {
      return 'Pleas a valid image URL end';
    }
    return null;
  }

  dynamic _descriptionValidator(String value) {
    if (value.isEmpty) {
      return 'Please Enter a description';
    }
    if (value.length < 10) {
      return 'Should be at least 10 characters long';
    }
    return null;
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
        child: _isLoading
            ? Center(child: CupertinoActivityIndicator(radius: 10))
            : GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () =>
                    // SystemChannels.textInput.invokeMethod('TextInput.hide'),
                    FocusScope.of(context).unfocus(),
                onPanDown: (_) =>
                    FocusScope.of(context).requestFocus(FocusNode()),
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
                        placeholder: 'Title',
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
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        padding: fieldPadding,
                        decoration: fieldDecoration,
                        clearButtonMode: _priceFoucusNode.hasFocus
                            ? OverlayVisibilityMode.editing
                            : OverlayVisibilityMode.never,
                        placeholder: 'Price',
                        textInputAction: TextInputAction.done,
                        focusNode: _priceFoucusNode,
                        onSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
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
                        placeholder: 'Description',
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
                                      child: Image.network(
                                          _imageUrlController.text),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Expanded(
                              child: CupertinoTextField(
                                decoration: fieldDecoration,
                                placeholder: 'Image url',
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
