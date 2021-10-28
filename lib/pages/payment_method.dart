import 'package:flutter/material.dart';
import 'package:happy_wash/ApiServices/user_services.dart';
import 'package:happy_wash/pages/payment_success.dart';
import 'package:happy_wash/pages/razorpay.dart';
import 'package:happy_wash/providers/order.dart';
import 'package:happy_wash/providers/user.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:provider/provider.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isLoading = false;
  bool isCod = false;
  bool isRazorpay = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isLoading = true;
              });
              var paymentMethod = isCod
                  ? 'Not Paid'
                  : isRazorpay
                      ? 'Paid'
                      : null;

              setState(() {
                isLoading = false;
              });
              openRaz() {
                RazorpayService razorpayService = new RazorpayService();
                razorpayService.initPaymentGateway(context);
                razorpayService.openCheckout(context);
              }

              cod() {
                var orderProvider =
                    Provider.of<OrderItem>(context, listen: false);
                orderProvider.setOrderStatus('Pending');
                orderProvider.setDateTime(DateTime.now());
                orderProvider.setPaymentStatus(paymentMethod);
                orderProvider.saveOrder(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentSuccess()),
                );
              }

              paymentMethod == null
                  ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please select payment method'),
                    ))
                  : (isRazorpay ? openRaz() : cod());
            },
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
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
                      'Procced to checkout',
                      15,
                      Colors.white,
                    ),
                  ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getAppBar(
                'Payment',
                backArrow(context),
                Container(),
                context,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: getBoldText('Choose Payment Method', 14, Colors.black),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCod = true;
                    isRazorpay = false;
                  });
                },
                child: Container(
                  height: 70,
                  color: isCod
                      ? MyColor.primaryColor.withOpacity(0.2)
                      : Colors.transparent,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/money 1.png'),
                          const SizedBox(
                            width: 20,
                          ),
                          getNormalText(
                            'Cash on Delivery',
                            14,
                            Colors.black,
                          ),
                        ],
                      ),
                      Icon(
                        isCod
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isCod ? MyColor.primaryColor : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isRazorpay = true;
                    isCod = false;
                  });
                },
                child: Container(
                  height: 70,
                  color: isRazorpay
                      ? MyColor.primaryColor.withOpacity(0.2)
                      : Colors.transparent,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/razorpay.jpeg'),
                          const SizedBox(
                            width: 20,
                          ),
                          getNormalText(
                            'Razorpay',
                            14,
                            Colors.black,
                          ),
                        ],
                      ),
                      Icon(
                        isRazorpay
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isRazorpay ? MyColor.primaryColor : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
