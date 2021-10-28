import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/providers/user.dart';
import 'package:provider/provider.dart';

class UserServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(BuildContext context) {
    var user = Provider.of<UserModel>(context, listen: false);

    return users
        .doc(user.id)
        .set({
          'phone': user.number,
          'name': user.name,
          'address': user.address,
          'landmark': user.landmark,
          'pin': user.pin,
          'email': user.email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<Map<String, dynamic>> getData(BuildContext context) async {
    // Get docs from collection reference
    var user = Provider.of<UserModel>(context, listen: false);
    DocumentSnapshot querySnapshot = await users.doc(user.id).get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.data();

    return allData;
  }
}
