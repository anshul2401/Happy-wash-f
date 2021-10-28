import 'package:flutter/material.dart';
import 'package:happy_wash/providers/package.dart';

class Packages with ChangeNotifier {
  final List<Package> _packages = [
    Package(
      id: 'RP1',
      title: 'Interior Wash',
      description: [
        "•	Dashboard clean and polish",
        "•	Car Interior Sanitisation",
        "•	Cleaning of hinges and side doors",
        "•	Complete Interior boot space cleaning",
        "•	Complete Interior vacuuming ",
        "•	Side doors panel polish",
        "•	Complete mirror/glass clean",
        "•	Water and Electricity is to be provided by the customer",
      ],
      type: 'Regular',
      price: 99,
    ),
    Package(
      id: 'RP2',
      title: 'Exterior Wash',
      description: [
        "•	Complete Car Water rinse ",
        "•	Exterior car foam wash",
        "•	Eco clean & gloss",
        "•	Clean front grill & mud flaps",
        "•	Complete chassis/Undercarriage wash",
        "•	Complete engine water rinse",
        "•	Complete mirror/glass clean",
        "•	Tyre polish",
        "•	Water and Electricity is to be provided by the customer",
      ],
      type: 'Regular',
      price: 149,
    ),
    Package(
      id: 'RP3',
      title: 'Standard Wash',
      description: [
        "•	Complete car water rinse",
        "•	Exterior car foam wash",
        "•	Clean front frill and mud flaps",
        "•	Dashboard clean and polish",
        "•	Complete Interior boot space cleaning",
        "•	Complete Interior vacuuming ",
        "•	Complete engine water rinse",
        "•	Complete mirror/glass clean",
        "•	Tyre Polish",
        "•	Water and Electricity is to be provided by the customer",
      ],
      type: 'Regular',
      price: 199,
    ),
    Package(
      id: 'RP4',
      title: 'Premium Wash',
      description: [
        "•	Complete car water rinse",
        "•	Exterior car foam wash",
        "•	Eco glass clean & gloss",
        "•	Clean front grill & mud flaps",
        "•	Dashboard cleaning & shine",
        "•	Car interior Sanitization ",
        "•	Cleaning of Hinges & side doors ",
        "•	Complete interior boot space cleaning",
        "•	Complete interior vacuuming",
        "•	Complete engine water rinse",
        "•	Complete chassis/Undercarriage wash",
        "•	Side doors panel polish",
        "•	Complete mirror/glass clean",
        "•	Tyre polish",
        "•	Water and Electricity is to be provided by the customer",
      ],
      type: 'Regular',
      price: 249,
    ),
    Package(
      id: 'RP5',
      title: 'Standard + Bike Wash',
      description: [
        "•	Complete car & Bike water rinse ",
        "•	Exterior car & Bike foam wash",
        "•	Clean front frill and mud flaps",
        "•	Dashboard clean and polish",
        "•	Complete Interior boot space cleaning",
        "•	Complete Interior vacuuming",
        "•	Complete engine water rinse of Car & Bike",
        "•	Complete mirror/glass clean",
        "•	Tyre polish",
        "•	Water and Electricity is to be provided by the customer",
      ],
      type: 'Regular',
      price: 199,
    ),
    Package(
      id: 'RP6',
      title: 'Premium + Bike Wash',
      description: [
        "•	Complete car & Bike water rinse",
        "•	Exterior car & Bike foam wash",
        "•	Eco clean and gloss of car & bike",
        "•	Clean front frill and mud flaps ",
        "•	Dashboard clean and polish",
        "•	Car Interior Sanitisation",
        "•	Cleaning of hinges and side doors",
        "•	Complete Interior boot space cleaning",
        "•	Complete Interior vacuuming",
        "•	Complete engine water rinse of Car & Bike",
        "•	Complete chassis/Undercarriage wash",
        "•	Side doors panel polish",
        "•	Complete mirror/glass clean",
        "•	Tyre polish",
        "•	Water and Electricity is to be provided by the customer",
      ],
      type: 'Regular',
      price: 249,
    ),
    Package(
      id: 'MP1',
      title: '2 Premium Wash (PM) ',
      description: [
        "•	Complete car water rinse",
        "•	Exterior car foam wash",
        "•	Eco glass clean & gloss",
        "•	Clean front grill & mud flaps",
        "•	Dashboard cleaning & shine",
        "•	Car interior Sanitization ",
        "•	Cleaning of Hinges & side doors ",
        "•	Complete interior boot space cleaning",
        "•	Complete interior vacuuming",
        "•	Complete engine water rinse",
        "•	Complete chassis/Undercarriage wash",
        "•	Side doors panel polish",
        "•	Complete mirror/glass clean",
        "•	Tyre polish",
        "•	Water and Electricity is to be provided by the customer",
      ],
      type: 'Monthly',
      price: 349,
    ),
    Package(
      id: 'MP2',
      title: '4 Premium Wash (PM)',
      description: [
        "•	Complete car water rinse",
        "•	Exterior car foam wash",
        "•	Eco glass clean & gloss",
        "•	Clean front grill & mud flaps",
        "•	Dashboard cleaning & shine",
        "•	Car interior Sanitization ",
        "•	Cleaning of Hinges & side doors ",
        "•	Complete interior boot space cleaning",
        "•	Complete interior vacuuming",
        "•	Complete engine water rinse",
        "•	Complete chassis/Undercarriage wash",
        "•	Side doors panel polish",
        "•	Complete mirror/glass clean",
        "•	Tyre polish",
        "•	Water and Electricity is to be provided by the customer",
      ],
      type: 'Monthly',
      price: 699,
    ),
  ];
  List<Package> get packages => _packages;
  void toggleIsAddedToCart(Package package) {
    package.isAddedToCart = !package.isAddedToCart;
    notifyListeners();
  }

  void toggleViewMore(Package package) {
    package.isShowMore = !package.isShowMore;
    notifyListeners();
  }

  List<Package> getCartItem() {
    return _packages.where((element) => element.isAddedToCart == true).toList();
  }

  int cartTotal() {
    int total = 0;
    getCartItem().forEach((element) {
      total += element.price;
    });
    return total;
  }
}
