import 'package:flutter/material.dart';
import 'package:happy_wash/main.dart';
import 'package:happy_wash/providers/order.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:provider/provider.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key key}) : super(key: key);

  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => App()),
                (Route<dynamic> route) => false);
          },
          child: Container(
            decoration: const BoxDecoration(
              color: MyColor.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            alignment: Alignment.center,
            height: 50,
            child: getNormalText(
              'Done',
              15,
              Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/sucess_img.png'),
            const SizedBox(
              height: 40,
            ),
            getBoldText(
              'Successfully Booked',
              20,
              Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            getNormalText(
              'You have successfully booked the wash',
              14,
              Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
