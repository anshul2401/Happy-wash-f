import 'package:flutter/material.dart';
import 'package:happy_wash/utils/helper.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              getAppBar('FAQ\'s', backArrow(context), Container(), context),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
                child: ListView(shrinkWrap: true, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 1,
                        child: ExpansionTile(
                          leading: Icon(Icons.help),

                          title: Text("How Long does the service Take?",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.justify),
                          childrenPadding: EdgeInsets.all(15),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          // subtitle: Text("  Sub Title's"),
                          children: <Widget>[
                            Text(
                              "HappyWash car care and detailing service completion time vary by size of vehicle, condition of vehicle and service selected.",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              "- Hatchback - 30-40 minutes",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              "- Sedan and Compact SUV - 40-50 minutes",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "- SUV - 1 hour",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              "- MUV - 1 hour 20 minute",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              "If you service your vehicle at home it normally takes 15 minutes for us to set up and 15 minutes to pack up our equipment. If you have your vehicle serviced at a commercial location-office parking etc. your key pick up time and key return time may be extended for a variety of operational reasons. If you need your car back by a certain time, please let us know while scheduling your appointment.",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 1,
                        child: ExpansionTile(
                          leading: Icon(Icons.help),

                          title: Text("Seden Vs Non Sedan Vs Hatchback",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.justify),
                          childrenPadding: EdgeInsets.all(15),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          // subtitle: Text("  Sub Title's"),
                          children: <Widget>[
                            Text(
                              'Sedan',
                              style: TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "4 doors or less and 2 rows of seats or less with extended booth space.",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Non Sedan',
                              style: TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "3rd row of seats and 3rd door hatch. (SUV, minivans, XL trucks).",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Hatchback',
                              style: TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "4 doors or less and 2 rows of seats or less and without extended booth space.",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "We reserve the right to apply additional fees for excessive dirt, sand, mold, dog hair or other factors that may impact the time required to serve your vehicle.",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 1,
                        child: ExpansionTile(
                          leading: Icon(Icons.help),

                          title: Text("How do I pay?",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.justify),
                          childrenPadding: EdgeInsets.all(15),
                          // subtitle: Text("  Sub Title's"),
                          children: <Widget>[
                            Text(
                              "HappyWash accepts credit card/debit card/net banking/cash payments for services.",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 1,
                        child: ExpansionTile(
                          leading: Icon(Icons.help),

                          title: Text("What about the damage to the car?",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.justify),
                          childrenPadding: EdgeInsets.all(15),
                          // subtitle: Text("  Sub Title's"),
                          children: <Widget>[
                            Text(
                              "Our technicians do a note of any obvious major damages to the vehicle (dents, deep scratches etc.) All cars are considered used and damaged to some extent- roap chips, minor scuffs, stains in carpets, etc. if you believe your vehicle to be in perfect condition, please note this on the service request and we will do a more detailed inspection prior to beginning services.",
                              style: TextStyle(fontSize: 15, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
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
