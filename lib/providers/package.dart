import 'package:flutter/material.dart';

class Package with ChangeNotifier {
  final String id;
  final String title;
  final String type;
  final List<String> description;
  final int price;
  bool isAddedToCart;
  bool isShowMore;
  Package({
    @required this.id,
    @required this.title,
    @required this.type,
    @required this.description,
    @required this.price,
    this.isAddedToCart = false,
    this.isShowMore = false,
  });
}
