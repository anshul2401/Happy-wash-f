import 'package:flutter/material.dart';
import 'package:happy_wash/providers/order.dart';

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
}
