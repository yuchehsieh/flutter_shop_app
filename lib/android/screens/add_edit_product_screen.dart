import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/providers/product.dart';

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

  Product _editedProduct = Product(
    id: '',
    price: null,
    title: '',
    imageUrl: '',
    description: '',
  );

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

  void _saveForm() {
    _form.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.id);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
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
                  decoration: InputDecoration(labelText: 'Title'),
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
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  focusNode: _priceFoucusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (String value) {
                    _editedProduct = Product(
                      description: _editedProduct.description,
                      title: _editedProduct.title,
                      id: _editedProduct.id,
                      imageUrl: _editedProduct.imageUrl,
                      price: double.parse(value),
                    );
                  },
                ),
                TextFormField(
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
                    );
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
                          );
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
