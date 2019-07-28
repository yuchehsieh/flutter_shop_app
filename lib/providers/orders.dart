import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://f2ewk11.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'quantity': cp.quantity,
                    'price': cp.price,
                    'title': cp.title,
                  })
              .toList()
        }),
      );
      // print(json.decode(response.body));
      // {name: -LkgQKNUj9SEK5eMJwyy}
      // print(json.decode(response.body)['name']);
      // -LkgQKNUj9SEK5eMJwyy
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timestamp,
          products: cartProducts,
        ),
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
