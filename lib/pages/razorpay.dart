import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/pages/payment_success.dart';
import 'package:happy_wash/providers/order.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  Razorpay _razorpay;
  BuildContext _buildContext;
  initPaymentGateway(BuildContext buildContext) {
    this._buildContext = buildContext;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccessful);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
  }

  void paymentError(PaymentFailureResponse response) {
    print(response.message);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => BookingFailed()));
  }

  void paymentSuccessful(PaymentSuccessResponse response) {
    var orderProvider = Provider.of<OrderItem>(_buildContext, listen: false);
    orderProvider.setOrderStatus('Pending');
    orderProvider.setDateTime(DateTime.now());
    orderProvider.setPaymentStatus("Paid");
    orderProvider.saveOrder(_buildContext);
    Navigator.pushReplacement(_buildContext,
        MaterialPageRoute(builder: (context) {
      return const PaymentSuccess();
    }));
  }

  void externalWallet(ExternalWalletResponse response) {
    print(response.walletName);
  }

  void openCheckout(BuildContext context) {
    var options = {
      "key": "rzp_test_ftqgz8hdue0pLi",
      "amount": 1000,
      "name": "Happy Wash",
      "description": "A step Away",
      "prefill": {
        "contact": '123456789',
        "email": 'anshulchouhan@gmail.com',
      },
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }
}
