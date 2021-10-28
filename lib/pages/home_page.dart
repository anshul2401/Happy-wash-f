import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/admin/home.dart';
import 'package:happy_wash/pages/choose_package.dart';
import 'package:happy_wash/pages/menu/notification.dart';
import 'package:happy_wash/providers/order.dart';
import 'package:happy_wash/utils/carousel.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:slide_drawer/slide_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _choosenCity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getAppBar(
                  'Happy Wash',
                  GestureDetector(
                    onTap: () {
                      SlideDrawer.of(context)?.toggle();
                    },
                    child: Container(
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
                        Icons.menu,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notifications()));
                    },
                    child: Container(
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
                        Icons.notifications_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  context,
                ),
                CarouselWithIndicatorDemo(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: getBoldText(
                    'Choose City',
                    15,
                    Colors.black,
                  ),
                ),
                getDropDown(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: getBoldText(
                    'Choose Your Car Segment',
                    15,
                    Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getSegment('Hatch Back', 'assets/images/hatchback.png'),
                    getSegment('Sedan', 'assets/images/sedan.png'),
                    getSegment('SUV', 'assets/images/suv.png'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSegment(String segmentName, String imgUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChoosePackage(
                    carType: segmentName,
                  )),
        );
        var orderItemProvider = Provider.of<OrderItem>(context, listen: false);
        orderItemProvider.setCarType(segmentName);
      },
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width / 3 - 20,
              height: MediaQuery.of(context).size.width / 3 - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15,
                ),
                color: MyColor.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(imgUrl),
              )),
          const SizedBox(
            height: 15,
          ),
          getNormalText(
            segmentName,
            15,
            Colors.black,
          )
        ],
      ),
    );
  }

  Widget getDropDown() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15,
          ),
          border: Border.all(
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            elevation: 0,
            isExpanded: true,
            focusColor: Colors.white,
            borderRadius: BorderRadius.circular(10),

            value: _choosenCity,
            //elevation: 5,
            style: const TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: <String>[
              'Ujjain',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            hint: const Text(
              "Choose City",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (String value) {
              setState(() {
                _choosenCity = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
