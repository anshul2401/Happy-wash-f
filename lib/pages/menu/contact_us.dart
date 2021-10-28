import 'package:flutter/material.dart';
import 'package:happy_wash/utils/helper.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({Key key}) : super(key: key);

  @override
  _ContactUSState createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              getAppBar('Contact us', backArrow(context), Container(), context),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(shrinkWrap: true, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Us',
                        style: TextStyle(fontSize: 18, fontFamily: 'Alegreya'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.phone_android,
                            size: 40,
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PHONE',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 127, 219, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Alegreya'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '+918989000910',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.email,
                            size: 40,
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'EMAIL',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 127, 219, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Alegreya'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'happywashops@gmail.com',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
