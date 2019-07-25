import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class MaterialAddEditProduct extends StatefulWidget {
  static const routeName = '/add-edit-product';

  @override
  _MaterialAddEditProductState createState() => _MaterialAddEditProductState();
}

class _MaterialAddEditProductState extends State<MaterialAddEditProduct> {
  final _priceFoucusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  bool _isInit = true;

  Product _editedProduct = Product(
    id: null,
    price: null,
    title: '',
    imageUrl: '',
    description: '',
  );

  Map<String, String> _initValues = {
    'price': '',
    'title': '',
    'imageUrl': '',
    'description': '',
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final String productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'price': _editedProduct.price.toString(),
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'imageUrl': '',
          // 'imageUrl': _editedProduct.imageUrl,
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }

    _isInit = false;

    super.didChangeDependencies();
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

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .upadteProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Produt '),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => SystemChannels.textInput.invokeMethod('TextInput.hide'),
          onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(
                    labelText: 'Title',
                    // errorStyle: null,
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFoucusNode);
                  },
                  onSaved: (String value) {
                    _editedProduct = Product(
                      description: _editedProduct.description,
                      title: value,
                      id: _editedProduct.id,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price,
                      isFavorite: _editedProduct.isFavorite,
                    );
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  focusNode: _priceFoucusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
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
                  },
                  onSaved: (String value) {
                    _editedProduct = Product(
                      description: _editedProduct.description,
                      title: _editedProduct.title,
                      id: _editedProduct.id,
                      imageUrl: _editedProduct.imageUrl,
                      price: double.parse(value),
                      isFavorite: _editedProduct.isFavorite,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (String value) {
                    _editedProduct = Product(
                      description: value,
                      title: _editedProduct.title,
                      id: _editedProduct.id,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price,
                      isFavorite: _editedProduct.isFavorite,
                    );
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter a description';
                    }
                    if (value.length < 10) {
                      return 'Should be at least 10 characters long';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocusNode,
                        controller: _imageUrlController,
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (String value) {
                          _editedProduct = Product(
                            description: _editedProduct.description,
                            title: _editedProduct.title,
                            id: _editedProduct.id,
                            imageUrl: value,
                            price: _editedProduct.price,
                            isFavorite: _editedProduct.isFavorite,
                          );
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter an image URL';
                          }
                          if (!value.startsWith('http') ||
                              !value.startsWith('https')) {
                            return 'Pleas a valid image URL start';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                            return 'Pleas a valid image URL end';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
