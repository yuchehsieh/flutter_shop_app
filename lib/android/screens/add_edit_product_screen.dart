import 'package:flutter/material.dart';

class MaterialAddEditProduct extends StatefulWidget {
  static const routeName = '/add-edit-product';

  @override
  _MaterialAddEditProductState createState() => _MaterialAddEditProductState();
}

class _MaterialAddEditProductState extends State<MaterialAddEditProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Produt '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
