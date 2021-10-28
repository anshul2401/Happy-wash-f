import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/utils/enums.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:slide_drawer/slide_drawer.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({Key key}) : super(key: key);

  @override
  _BookingHistoryState createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  bool isPending = true;
  bool isCompleted = false;
  bool isCancelled = false;

  final Stream<QuerySnapshot> orderStream =
      FirebaseFirestore.instance.collection('orders').snapshots();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: orderStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List data = [];
        snapshot.data.docs.map((DocumentSnapshot doc) {
          Map a = doc.data() as Map<String, dynamic>;
          data.add(a);
        }).toList();
        List dataa = data.where((e) {
          return e['user_id'] == _auth.currentUser.uid.toString();
        }).toList();
        List filteredData = [];
        if (isPending) {
          filteredData = dataa
              .where((element) => element['order_status'] == 'Pending')
              .toList();
        }
        if (isCompleted) {
          filteredData = dataa
              .where((element) => element['order_status'] == 'Completed')
              .toList();
        }
        if (isCancelled) {
          filteredData = dataa
              .where((element) => element['order_status'] == 'Cancelled')
              .toList();
        }
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  getAppBar(
                    'Booking History',
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
                    Container(),
                    context,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        border: Border.all(
                          width: 0.5,
                          color: MyColor.primaryColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isPending = true;
                                isCompleted = false;
                                isCancelled = false;
                              });
                            },
                            child: Container(
                              height: 49.5,
                              width: MediaQuery.of(context).size.width / 3 - 13,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                                color: isPending
                                    ? MyColor.primaryColor
                                    : Colors.transparent,
                              ),
                              alignment: Alignment.center,
                              child: getNormalText(
                                'Pending',
                                15,
                                isPending ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isPending = false;
                                isCompleted = true;
                                isCancelled = false;
                              });
                            },
                            child: Container(
                              height: 49.5,
                              width: MediaQuery.of(context).size.width / 3 - 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                                color: isCompleted
                                    ? MyColor.primaryColor
                                    : Colors.transparent,
                              ),
                              alignment: Alignment.center,
                              child: getNormalText(
                                'Completed',
                                15,
                                isCompleted ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isPending = false;
                                isCompleted = false;
                                isCancelled = true;
                              });
                            },
                            child: Container(
                              height: 49.5,
                              width: MediaQuery.of(context).size.width / 3 - 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                                color: isCancelled
                                    ? MyColor.primaryColor
                                    : Colors.transparent,
                              ),
                              alignment: Alignment.center,
                              child: getNormalText(
                                'Cancelled',
                                15,
                                isCancelled ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  filteredData.isNotEmpty
                      ? Expanded(
                          child: getData(filteredData),
                        )
                      : getBoldText(
                          'Your booking history is empty!',
                          15,
                          Colors.grey,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getData(List data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return getListTile(data[index]);
        });
  }

  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  Future<void> updateUser(data) {
    return orders
        .doc(data['order_id'])
        .update({'order_status': 'Cancelled'})
        .then((value) => print("Order Cancelled"))
        .catchError((error) => print("Failed to cancel: $error"));
  }

  Widget getListTile(Map<String, dynamic> data) {
    return isPending
        ? Dismissible(
            key: ObjectKey(data.keys),
            // onDismissed: (direction) {
            //   cancelOrder(data, context);
            // },
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text(
                        "Are you sure you wish to cancel the booking?"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            updateUser(data);
                            Navigator.of(context).pop(true);
                          },
                          child: const Text("YES")),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("NO"),
                      ),
                    ],
                  );
                },
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.block,
                      color: Colors.white,
                      size: 50,
                    ),
                    getNormalText(
                      'Cancel',
                      18,
                      Colors.white,
                    )
                  ],
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      border: Border.all(
                        width: 0.5,
                        color: isCancelled
                            ? Colors.red
                            : isCompleted
                                ? Colors.green
                                : Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Icon(
                                  Icons.car_rental,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ),
                              Container(
                                width: 0.5,
                                height: 100,
                                color: isCancelled
                                    ? Colors.red
                                    : isCompleted
                                        ? Colors.green
                                        : Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: data['packages'].length,
                                        itemBuilder: (context, index) {
                                          return getBoldText(
                                            data['packages'][index],
                                            15,
                                            Colors.black,
                                          );
                                        },
                                      ),
                                    ),
                                    getNormalText(
                                      '₹ ${data['total_amount']}',
                                      16,
                                      Colors.black,
                                    ),
                                    getNormalText(
                                      data['wash_date'] +
                                          ' at ' +
                                          data['wash_time'],
                                      14,
                                      MyColor.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        isPending
                            ? const Icon(
                                Icons.alarm,
                                color: Colors.yellow,
                              )
                            : isCompleted
                                ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.block,
                                    color: Colors.red,
                                  ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    border: Border.all(
                      width: 0.5,
                      color: isCancelled
                          ? Colors.red
                          : isCompleted
                              ? Colors.green
                              : Colors.grey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Icon(
                                Icons.car_rental,
                                color: Colors.grey,
                                size: 50,
                              ),
                            ),
                            Container(
                              width: 0.5,
                              height: 100,
                              color: isCancelled
                                  ? Colors.red
                                  : isCompleted
                                      ? Colors.green
                                      : Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: data['packages'].length,
                                      itemBuilder: (context, index) {
                                        return getBoldText(
                                          data['packages'][index],
                                          15,
                                          Colors.black,
                                        );
                                      },
                                    ),
                                  ),
                                  getNormalText(
                                    '₹ ${data['total_amount']}',
                                    16,
                                    Colors.black,
                                  ),
                                  getNormalText(
                                    data['wash_date'] +
                                        ' at ' +
                                        data['wash_time'],
                                    14,
                                    MyColor.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      isPending
                          ? const Icon(
                              Icons.alarm,
                              color: Colors.yellow,
                            )
                          : isCompleted
                              ? const Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.block,
                                  color: Colors.red,
                                ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
