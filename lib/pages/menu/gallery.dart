import 'package:flutter/material.dart';
import 'package:happy_wash/utils/helper.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              getAppBar('Gallery', backArrow(context), Container(), context),
            ],
          ),
        ),
      ),
    );
  }
}
