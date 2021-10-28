import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/admin/order_detail.dart';
import 'package:happy_wash/main.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:intl/intl.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isPending = true;
  bool isCompleted = false;
  bool isCancelled = false;
  DateTime pickedDate = DateTime.now();
  final Stream<QuerySnapshot> orderStream =
      FirebaseFirestore.instance.collection('orders').snapshots();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    void _presentDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2019),
              lastDate: DateTime(2030))
          .then((value) {
        if (value == null) {
          return;
        }

        setState(() {
          pickedDate = value;
        });
      });
    }

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
          return e['wash_date'] ==
              DateFormat('dd-MM-yyyy').format(pickedDate).toString();
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
            drawer: Drawer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getBoldText('Hello, admin', 20, Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getNormalText('Cancel Date Time', 15, Colors.black),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getNormalText('Notification', 15, Colors.black),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => App()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getNormalText('Log out', 15, Colors.black),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            key: _scaffoldKey,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  getAppBar(
                    'Orders',
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState.openDrawer();
                        // _scaffoldKey.currentState.openEndDrawer();
                      },
                      child: Container(
                        alignment: Alignment.center,
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
                        _presentDatePicker();
                      },
                      child: Container(
                        alignment: Alignment.center,
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
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                      ),
                    ),
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
                          'No order here',
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
            onDismissed: (direction) {
              updateUser(data);
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
            direction: isPending ? DismissDirection.endToStart : null,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderDetail(data)));
              },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
