import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/main.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          getBoldText(
            index == 0 ? 'CLEAR CAR' : 'SANITIZED',
            25,
            Colors.white,
          ),
          const SizedBox(
            height: 50,
          ),
          index == 0
              ? Image.asset('assets/images/intro1_com.png')
              : Image.asset('assets/images/intro2_com.png'),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    index == 0 ? getRectanular() : getCircular(),
                    index == 0 ? getCircular() : getRectanular(),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                getBoldText(
                  'Our three step process..',
                  20,
                  Colors.black,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30.0),
                  child: getNormalText(
                    'Happywash provides professional car cleaning service at your doorstep.Our  unique three layer car wash formula (water, foam and eco-friendly spray) gives your car a brand new mirror finish and with the service at comfort of your home.',
                    15,
                    Colors.grey,
                  ),
                ),
                index == 1
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => App()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                              color: MyColor.primaryColor,
                            ),
                            child: getNormalText(
                              'Get Started',
                              15,
                              Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => App()));
                              },
                              child: getNormalText(
                                'Skip Now',
                                15,
                                Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  index == 0
                                      ? index = 1
                                      : Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BottomNavBar()));
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                  color: MyColor.primaryColor,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: MyColor.primaryColor,
                                      size: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }

  getCircular() {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 2.0,
      ),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
    );
  }

  getRectanular() {
    return Container(
      width: 32.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 2.0,
      ),
      decoration: const BoxDecoration(
        color: MyColor.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    );
  }
}
