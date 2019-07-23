import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/orders.dart';

class CupertinoOrderItem extends StatefulWidget {
  final OrderItem order;

  CupertinoOrderItem(this.order);

  @override
  _CupertinoOrderItemState createState() => _CupertinoOrderItemState();
}

class _CupertinoOrderItemState extends State<CupertinoOrderItem> {
  bool _isExpanded = false;

  _toggleCollpased() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd-MM-yyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: CupertinoButton(
              child: _isExpanded
                  ? Icon(CupertinoIcons.up_arrow)
                  : Icon(CupertinoIcons.down_arrow),
              onPressed: _toggleCollpased,
            ),
          ),
          AnimatedContainer(
            height: _isExpanded
                ? min(widget.order.products.length * 20.0 + 10.0, 180)
                : 0,
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: ListView(
              children: widget.order.products
                  .map(
                    (prod) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          prod.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${prod.quantity}x \$${prod.price}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
