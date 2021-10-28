import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';

class OrderDetail extends StatefulWidget {
  final Map<String, dynamic> data;
  const OrderDetail(this.data);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');

    Future<void> updateOrder(data, String status) {
      return orders
          .doc(data['order_id'])
          .update({'order_status': status})
          .then((value) => print("Order $status"))
          .catchError((error) => print("Failed to cancel: $error"));
    }

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getAppBar(
              'Order detail',
              backArrow(context),
              Container(),
              context,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getfield('Name', widget.data['name']),
                    getfield('Address', widget.data['address']),
                    // getfield('Landmark', widget.data['landmark']),
                    getfield('Phone', widget.data['phone']),
                    getfield(
                      'Date and Time',
                      widget.data['wash_date'] +
                          ' at ' +
                          widget.data['wash_time'],
                    ),
                    getfield('Car Model', widget.data['car_type']),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getNormalText(
                          'Packages',
                          13,
                          MyColor.primaryColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.data['packages'].length,
                            itemBuilder: (context, index) {
                              return getNormalText(
                                widget.data['packages'][index],
                                16,
                                Colors.black,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    getfield(
                      'Payment Status',
                      widget.data['payment_status'],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          shape: const StadiumBorder(),
                          color: MyColor.primaryColor,
                          child: getNormalText('Completed', 13, Colors.white),
                          onPressed: () async {
                            await updateOrder(widget.data, 'Completed');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Order Status updated'),
                            ));
                          },
                        ),
                        RaisedButton(
                          shape: const StadiumBorder(),
                          color: MyColor.primaryColor,
                          child: getNormalText('Share', 13, Colors.white),
                          onPressed: () {
                            SocialShare.shareWhatsapp('NAME: ' +
                                widget.data['name'] +
                                '\n' +
                                'ADDRESS: ' +
                                widget.data['address'] +
                                '\n' +
                                'PHONE: ' +
                                widget.data['phone'] +
                                '\n' +
                                'DATE AND TIME: ' +
                                widget.data['wash_date'] +
                                ' at ' +
                                widget.data['wash_time'] +
                                '\n' +
                                'CAR MODEL: ' +
                                widget.data['car_type'] +
                                '\n' +
                                'PACKGAE: ' +
                                widget.data['package'][0] +
                                '\n' +
                                'PAYMENT STATUS: ' +
                                widget.data['payment_status']);
                          },
                        ),
                        RaisedButton(
                          shape: const StadiumBorder(),
                          color: Colors.redAccent,
                          child: getNormalText('Cancel', 13, Colors.white),
                          onPressed: () async {
                            await updateOrder(widget.data, 'Cancelled');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Order Status updated'),
                            ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  getfield(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getNormalText(
          title,
          13,
          MyColor.primaryColor,
        ),
        const SizedBox(
          height: 10,
        ),
        getNormalText(
          data,
          16,
          Colors.black,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
