import 'package:flutter/material.dart';
import 'package:happy_wash/utils/helper.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final String aboutus =
        'HappyWash provide Car Cleaning/Washing service to our customers at the convenience of their home, office, or any other location which customer wants. Our trained, experienced, talented and passionate professionals provide the Best car Cleaning service at the doorstep of the customers. Technology helps in identifying problem at the root and communicate our professionals to carry necessary tools to complete the service.HappyWash redefines the entire car care experience. No longer do customers have to deal with inconvenient, inconsistent and frustrating visits to fixed car wash locations, instead, by using mobile apps, one can book and avail complete car washing services at any location he prefers and our mobile team will reach there in the scheduled time.Not only that all our employees have been background checked to ensure that we service your request on time by trusted people who are 100% accountable for quality service. We run police verification checks, reference checks etc to ensure that the service we offer is secure and your vehicle is at safe hands.';

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              getAppBar('About us', backArrow(context), Container(), context),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Us',
                      style: TextStyle(fontSize: 20, fontFamily: 'Alegreya'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        aboutus,
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Why Choose HappyWash?',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'HappyWash is the simplest and most reliable car cleaning mobile app to keep your car clean at your doorstep. We offer services like car wash, interior detailing, exterior detailing, Car sanitization, which has became essential due to COVID-19 outbreak. Our Unique three layer car wash formula (Water, foam & eco friendly spray) gives your car a brand new mirror finish and with service at comfort of your home.',
                      style: TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
