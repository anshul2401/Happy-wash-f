import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_wash/pages/cart.dart';

Text getBoldText(String text, double fontSize, Color color) {
  return Text(
    text,
    style: GoogleFonts.varelaRound(
        textStyle: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
    )),
  );
}

Text getNormalText(String text, double fontSize, Color color) {
  return Text(
    text,
    style: GoogleFonts.varelaRound(
        textStyle: TextStyle(
      fontSize: fontSize,
      color: color,
    )),
  );
}

Widget getAppBar(
    String title, Widget leftItem, Widget rightItem, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 5,
      vertical: 20,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftItem,
        getBoldText(title, 15, Colors.black),
        rightItem,
      ],
    ),
  );
}

Widget backArrow(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pop();
    },
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15,
        ),
        border: Border.all(
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
  );
}

bool isAdmin(String val) {
  List<String> admin = [
    '+919340133342',
    '+918888888888',
    '+918147016636',
    '+919716632324',
    '+919179711289',
    '+919739363208',
  ];
  bool isAdmin;
  admin.contains(val) ? isAdmin = true : isAdmin = false;
  return isAdmin;
}
