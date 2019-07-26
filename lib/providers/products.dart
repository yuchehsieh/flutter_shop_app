import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  bool _showFavoritesOnly = false;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://f2ewk11.firebaseio.com/products.json';
    var response;
    try {
      response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'description': product.description,
            'isFavorite': product.isFavorite,
          }));
    } catch (e) {
      print('error dude!');
    }
    print(json.decode(response.body));
    // -> {name: -LkgQKNUj9SEK5eMJwyy}

    final newProduct = Product(
      title: product.title,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
      id: json.decode(response.body)['name'],
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); /* at the start of the List */
    notifyListeners();
    return response;
  }

  void upadteProduct(String productId, Product newProduct) {
    final prodIndex = _items.indexWhere((product) => product.id == productId);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('....');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
