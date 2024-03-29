// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/admin/home.dart';
import 'package:happy_wash/pages/user_details.dart';
import 'package:happy_wash/providers/order.dart';
import 'package:happy_wash/providers/package.dart';
import 'package:happy_wash/providers/packages.dart';
import 'package:happy_wash/providers/user.dart';
import 'package:happy_wash/utils/enums.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final otpController = TextEditingController();
  final phoneController = TextEditingController();
  bool showLoading = false;
  String verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var packageProvider = Provider.of<Packages>(context);
    List<Package> package = packageProvider.getCartItem().toList();

    var orderProvider = Provider.of<OrderItem>(context);
    orderProvider.setTotalAmount(packageProvider.cartTotal().toString());
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: GestureDetector(
            onTap: () {
              var packageProvider =
                  Provider.of<Packages>(context, listen: false);
              var packagess = packageProvider.getCartItem();
              List<String> packages = [];
              for (var element in packagess) {
                packages?.add(element.title);
              }
              var orderItemProvider =
                  Provider.of<OrderItem>(context, listen: false);

              orderItemProvider.setPackage(packages);

              _auth.currentUser == null
                  ? showMe(context)
                  : Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserDetails()));
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
                'Login for booking',
                15,
                Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getAppBar(
                'My Cart',
                backArrow(context),
                Container(),
                context,
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: package.length,
                    itemBuilder: (context, index) {
                      return getCard(package[index]);
                    }),
              ),
              getPriceContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPriceContainer() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          getNormalText(
            'Have a coupon code? Enter here',
            13,
            Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15,
              ),
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    autocorrect: false,
                    onSaved: (newValue) {
                      // name = newValue;
                    },
                    onChanged: (val) {
                      print(val);
                    },
                    // initialValue: name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                ),
                getNormalText('Available', 13, Colors.green),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.check_circle,
                  size: 15,
                  color: Colors.green,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          getPriceRow(
            'Subtotal:',
            context.read<Packages>().cartTotal(),
          ),
          SizedBox(
            height: 20,
          ),
          getPriceRow(
            'Net Service',
            0,
          ),
          SizedBox(
            height: 20,
          ),
          getPriceRow(
            'Discount',
            0,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          getTotalAmountRow(
            'Total',
            context.read<Packages>().cartTotal(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget getPriceRow(String type, int price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getNormalText(
          type,
          13,
          Colors.grey,
        ),
        getNormalText(
          '₹ ${price.toString()}',
          14,
          Colors.black,
        )
      ],
    );
  }

  Widget getTotalAmountRow(String type, int price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getNormalText(
          type,
          13,
          Colors.grey,
        ),
        getBoldText(
          '₹ ${price.toString()}',
          16,
          Colors.green,
        ),
      ],
    );
  }

  void showMe(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext contex) {
        return StatefulBuilder(
          builder: (context, StateSetter setState1) {
            return showLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                // : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                //     ? getLoginWidget(context)
                //     : getOtpWidget(context);
                // : getLoginWidget(context, setState1);
                : getLoginWidget(context, setState1);
          },
        );
      },
    );
  }

  Widget getLoginWidget(BuildContext context, StateSetter setS) {
    return currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
        ? Container(
            height: 500,
            padding: MediaQuery.of(context).viewInsets,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          getBoldText(
                            'Login Account',
                            15,
                            Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          getNormalText(
                            'Hello, Welcome back to account',
                            14,
                            Colors.grey,
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
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
                            Icons.clear,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  getBoldText(
                    'Phone number',
                    14,
                    Colors.black,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: Image.asset(
                              'icons/flags/png/in.png',
                              package: 'country_icons',
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        getNormalText(
                          '+91',
                          15,
                          Colors.black,
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        showLoading = true;
                      });
                      setS(() {
                        showLoading = true;
                      });
                      phoneController.text = '+91' + phoneController.text;

                      await _auth.verifyPhoneNumber(
                        phoneNumber: phoneController.text,
                        verificationCompleted: (phoneAuthCredential) async {
                          setState(
                            () {
                              showLoading = false;
                            },
                          );
                          setS(() {
                            showLoading = false;
                          });

                          //signInWithPhoneAuthCredential(phoneAuthCredential);
                        },
                        verificationFailed: (verificationFailed) async {
                          setState(() {
                            showLoading = false;
                          });
                          setS(() {
                            showLoading = false;
                          });
                          Navigator.of(context).pop();
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(verificationFailed.message)));
                        },
                        codeSent: (verificationId, resendingToken) async {
                          setState(() {
                            showLoading = false;
                            currentState =
                                MobileVerificationState.SHOW_OTP_FORM_STATE;
                            this.verificationId = verificationId;
                          });
                          setS(() {
                            currentState =
                                MobileVerificationState.SHOW_OTP_FORM_STATE;
                            showLoading = false;
                          });
                        },
                        codeAutoRetrievalTimeout: (verificationId) async {},
                      );
                    },
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
                        'Send Code',
                        15,
                        Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : getOtpWidget(context, setS);
  }

  Widget getOtpWidget(BuildContext context, StateSetter setS) {
    return Container(
      height: 500,
      padding: MediaQuery.of(context).viewInsets,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
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
                        Icons.clear,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: Image.asset('assets/images/otp.png'),
                height: 100,
              ),
              SizedBox(
                height: 10,
              ),
              getBoldText(
                'Verification',
                20,
                Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              getNormalText(
                'Please Enter the OTP code sent to you at',
                15,
                Colors.grey,
              ),
              getNormalText(
                phoneController.text,
                15,
                Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpController.text);

                  signInWithPhoneAuthCredential(phoneAuthCredential, setS);
                },
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
                    'Verfiy',
                    15,
                    Colors.white,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget getCard(Package package) {
    return Padding(
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
                color: Colors.grey,
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
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 120,
                              child: getNormalText(
                                package.title,
                                15,
                                Colors.grey,
                              ),
                            ),
                            getBoldText(
                              '₹ ${package.price.toString()}',
                              16,
                              Colors.black,
                            ),
                            getNormalText(
                              'View more details',
                              14,
                              MyColor.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                !package.isAddedToCart
                    ? GestureDetector(
                        onTap: () {
                          Provider.of<Packages>(context, listen: false)
                              .toggleIsAddedToCart(package);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: MyColor.primaryColor,
                          ),
                          child: getNormalText(
                            'Add',
                            15,
                            Colors.white,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          // context.read<Packages>().toggleIsAddedToCart(package)
                          Provider.of<Packages>(context, listen: false)
                              .toggleIsAddedToCart(package);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: Colors.green,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    50,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              getNormalText(
                                'Add',
                                15,
                                Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(
          //       15,
          //     ),
          //     border: Border.all(
          //       width: 0.5,
          //       color: Colors.grey,
          //     ),
          //   ),
          //   child: getNormalText(
          //     'hh',
          //     15,
          //     Colors.black,
          //   ),
          // )
        ],
      ),
    );
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential, StateSetter setS) async {
    setState(() {
      showLoading = true;
    });
    setS(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential?.user != null) {
        var userProvider = Provider.of<UserModel>(context, listen: false);
        await userProvider.setNumber(phoneController.text);
        await userProvider.setUserId(_auth.currentUser.uid);
        await userProvider.fetchUser(context);
        // addUser(customer.id.toString(), phoneController.text, 'Customer');
        setState(() {
          showLoading = false;
        });
        setS(() {
          showLoading = false;
        });
        Navigator.of(context).pop();
        isAdmin(phoneController.text)
            ? Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AdminHomePage()))
            : Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserDetails()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      setS(() {
        showLoading = false;
      });
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
