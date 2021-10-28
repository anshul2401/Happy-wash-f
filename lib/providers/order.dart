import 'package:flutter/material.dart';
import 'package:happy_wash/ApiServices/order_services.dart';
import 'package:uuid/uuid.dart';

class OrderItem with ChangeNotifier {
  OrderServices orderServices = OrderServices();
  String _orderId;
  List<String> _packages;
  String _carType;
  String _washDate;
  String _washTime;
  String _userId;
  String _paymentStatus;
  String _orderStatus;
  String _totalAmount;
  String _name;
  String _address;
  String _landmark;
  String _phone;
  DateTime _dateTime;
  var uuid = const Uuid();

  String get orderId => _orderId;
  List<String> get packages => _packages;
  String get carType => _carType;
  String get washDate => _washDate;
  String get washTime => _washTime;
  String get userId => _userId;
  String get paymentStatus => _paymentStatus;
  String get orderStatus => _orderStatus;
  String get totalAmount => _totalAmount;
  String get name => _name;
  String get address => _address;
  String get landmark => _landmark;
  String get phone => _phone;
  DateTime get dateTime => _dateTime;

  setUserId(String value) {
    _userId = value;
    notifyListeners();
  }

  setPackage(List<String> value) {
    _packages = value;
    notifyListeners();
  }

  setCarType(String value) {
    _carType = value;
    notifyListeners();
  }

  setWashDate(String value) {
    _washDate = value;
    notifyListeners();
  }

  setWashTime(String value) {
    _washTime = value;
    notifyListeners();
  }

  setPaymentStatus(String value) {
    _paymentStatus = value;
    notifyListeners();
  }

  setOrderStatus(String value) {
    _orderStatus = value;
    notifyListeners();
  }

  setDateTime(DateTime value) {
    _dateTime = value;
    notifyListeners();
  }

  setTotalAmount(String value) {
    _totalAmount = value;
  }

  setName(String value) {
    _name = value;
    notifyListeners();
  }

  setAddress(String value) {
    _address = value;
    notifyListeners();
  }

  setLandmark(String value) {
    _landmark = value;
    notifyListeners();
  }

  setPhone(String value) {
    _phone = value;
    notifyListeners();
  }

  saveOrder(BuildContext context) async {
    _orderId = uuid.v4();
    await orderServices.addOrder(context);
  }
}
