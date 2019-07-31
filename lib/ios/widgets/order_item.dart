import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/orders.dart';

enum ExpandedState { Expanded, Collapsed }

class CupertinoOrderItem extends StatefulWidget {
  final OrderItem order;

  CupertinoOrderItem(this.order);

  @override
  _CupertinoOrderItemState createState() => _CupertinoOrderItemState();
}

class _CupertinoOrderItemState extends State<CupertinoOrderItem>
    with SingleTickerProviderStateMixin {
  ExpandedState _expandedState;
  AnimationController _controller;
  Animation<double> _rotateAnimation;

  @override
  initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: _controller,
      ),
    );

    super.initState();
  }

  _toggleCollpased() {
    if (_expandedState == ExpandedState.Expanded) {
      setState(() {
        _expandedState = ExpandedState.Collapsed;
      });
      _controller.reverse();
    } else {
      setState(() {
        _expandedState = ExpandedState.Expanded;
      });
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd-MM-yyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: RotationTransition(
              turns: _rotateAnimation,
              alignment: Alignment.center,
              child: CupertinoButton(
                child: Icon(CupertinoIcons.down_arrow),
                onPressed: _toggleCollpased,
              ),
            ),
          ),
          AnimatedContainer(
            height: _expandedState == ExpandedState.Expanded
                ? min(widget.order.products.length * 30.0 + 10.0, 180)
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
