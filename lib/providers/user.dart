import 'package:flutter/material.dart';
import 'package:happy_wash/ApiServices/user_services.dart';

class UserModel with ChangeNotifier {
  final userService = UserServices();
  String _name;
  String _email;
  String _id;
  String _address;
  String _number;
  String _landmark;
  String _pin;

  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get address => _address;
  String get number => _number;
  String get landmark => _landmark;
  String get pin => _pin;

  setUserId(val) {
    _id = val;
  }

  setName(val) {
    _name = val;
    notifyListeners();
  }

  setEmail(val) {
    _email = val;
    notifyListeners();
  }

  setAddress(val) {
    _address = val;
    notifyListeners();
  }

  setNumber(val) {
    _number = val;
    notifyListeners();
  }

  setLandmark(val) {
    _landmark = val;
    notifyListeners();
  }

  setPin(val) {
    _pin = val;
    notifyListeners();
  }

  saveUser(BuildContext context) async {
    await userService.addUser(context);
  }

  fetchUser(BuildContext context) async {
    var userDetails = await userService.getData(context);
    _name = userDetails['name'];
    _address = userDetails['address'];
    _email = userDetails['email'];
    _landmark = userDetails['landmark'];
    _pin = userDetails['pin'];
    // notifyListeners();
  }
}
