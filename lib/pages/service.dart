import 'package:flutter/material.dart';
import 'package:happy_wash/utils/helper.dart';

class ChooseService extends StatefulWidget {
  const ChooseService({Key key}) : super(key: key);

  @override
  _ChooseServiceState createState() => _ChooseServiceState();
}

class _ChooseServiceState extends State<ChooseService> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            getAppBar(
              'Choose Service',
              Container(),
              Container(),
              context,
            ),
          ],
        ),
      ),
    ));
  }
}
