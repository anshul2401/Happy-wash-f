import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/ApiServices/order_services.dart';
import 'package:happy_wash/date_picker/date_picker_widget.dart';
import 'package:happy_wash/pages/cart.dart';
import 'package:happy_wash/providers/order.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({Key key}) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  final DatePickerController _controller = DatePickerController();
  String _pickedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String _pickedTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            var orderItemProvider =
                Provider.of<OrderItem>(context, listen: false);

            orderItemProvider.setWashDate(_pickedDate);
            orderItemProvider.setWashTime(_pickedTime);
            _pickedTime == null
                ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please select time'),
                  ))
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Cart()),
                  );
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
              'Go to Cart',
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
              'Pick Date & Time',
              backArrow(context),
              Container(),
              context,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8,
                top: 8,
              ),
              child: getBoldText('Select Date', 15, Colors.black),
            ),
            getDatePicker(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getBoldText('Select Time', 15, Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTimeSlot('09:00 AM'),
                  getTimeSlot('10:30 AM'),
                  getTimeSlot('12:00 PM')
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTimeSlot('01:30 PM'),
                  getTimeSlot('03:00 PM'),
                  getTimeSlot('04:30 PM')
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<bool> isTakne(String timeSlot) async {
    bool isTaken;
    await FirebaseFirestore.instance
        .collection('orders')
        .where('wash_date', isEqualTo: _pickedDate)
        .where('wash_time', isEqualTo: timeSlot)
        .where('order_status', isEqualTo: 'Pending')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        isTaken = true;
      } else {
        isTaken = false;
      }
    });
    return isTaken;
  }

  Widget getTimeSlot(String timeSlot) {
    // OrderServices orderServices = OrderServices();

    // bool isTaken = orderServices.getData(context, timeSlot, _pickedDate);

    return FutureBuilder<bool>(
      future: isTakne(timeSlot),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == false) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _pickedTime = timeSlot;
                // isTaken ? null : _pickedTime = timeSlot;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: _pickedTime == timeSlot
                    ? MyColor.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  10,
                ),
                border: Border.all(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: getBoldText(
                  timeSlot,
                  15,
                  _pickedTime == timeSlot ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              setState(() {
                // isTaken ? null : _pickedTime = timeSlot;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: _pickedTime == timeSlot
                    ? MyColor.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  10,
                ),
                border: Border.all(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: getBoldText(
                  timeSlot,
                  15,
                  Colors.grey,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget getDatePicker() {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DatePicker(
            DateTime.now(),
            width: 60,
            height: 80,
            controller: _controller,
            initialSelectedDate: DateTime.now(),
            selectionColor: MyColor.primaryColor,
            selectedTextColor: Colors.white,
            // inactiveDates: [
            //   DateTime.now().add(Duration(days: 3)),
            //   DateTime.now().add(Duration(days: 4)),
            //   DateTime.now().add(Duration(days: 7))
            // ],
            onDateChange: (date) {
              setState(() {
                final DateFormat formatter = DateFormat('dd-MM-yyyy');
                _pickedTime = null;
                _pickedDate = formatter.format(date);
              });
            },
          ),
        ],
      ),
    );
  }
}
