import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final String userId;

  Products(
    this.authToken,
    this.userId,
    this._items,
  );

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

  Future<void> fetchAndSetProducts() async {
    String url = 'https://f2ewk11.firebaseio.com/products.json?auth=$authToken';

    try {
      final response = await http.get(url);
      final List<Product> loadedProducts = [];
      final Map<String, dynamic> extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      // fetch user favorites
      url =
          'https://f2ewk11.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      // print(json.decode(favoriteResponse.body));
      // {-LkwhOp8GsO0QVZFXUur: true}

      extractedData.forEach((key, value) {
        loadedProducts.add(Product(
          title: value['title'],
          description: value['description'],
          id: key,
          imageUrl: value['imageUrl'],
          price: value['price'],
          isFavorite: favoriteData == null ? false : favoriteData[key] ?? false,
        ));
        _items = loadedProducts;
        notifyListeners();
      });
      /* print(json.decode(response.body));
        {
          -LkgOQHCftVIHQYHfoMv: {description: desssssssssss, imageUrl: https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg, isFavorite: false, price: 19.9, title: test},
          -LkgPnBG3-PFUpIIay0B: {description: https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg, imageUrl: https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg, isFavorite: false, price: 19.5, title: test},
        }
      */
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = 'https://f2ewk11.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'description': product.description,
          }));
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
    } catch (e) {
      print('error dude!');
      throw e;
    }
  }

  Future<void> upadteProduct(String productId, Product newProduct) async {
    final url =
        'https://f2ewk11.firebaseio.com/products/$productId.json?auth=$authToken';
    final prodIndex = _items.indexWhere((product) => product.id == productId);
    if (prodIndex >= 0) {
      try {
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'price': newProduct.price,
              'imageUrl': newProduct.imageUrl,
              'description': newProduct.description
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (e) {
        throw e;
      }
    } else {
      print('....');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://f2ewk11.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProdIndex = _items.indexWhere((prod) => prod.id == id);
    Product existingProduct = _items[existingProdIndex];
    // store the refrence of the product
    // that won't be clear in memory
    _items.removeAt(existingProdIndex);
    notifyListeners();
    try {
      final response = await http.delete(url);
      if (response.statusCode > 400) {
        _items.insert(existingProdIndex, existingProduct);
        notifyListeners();
        throw HttpException('Could not delete product');
      }
      existingProduct = null;
    } catch (e) {
      throw HttpException('Could not delete product');
    }
  }
}
