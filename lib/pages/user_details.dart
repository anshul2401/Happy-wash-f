import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/ApiServices/user_services.dart';
import 'package:happy_wash/pages/payment_method.dart';
import 'package:happy_wash/providers/order.dart';
import 'package:happy_wash/providers/user.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _form = GlobalKey<FormState>();
  String address;
  String name;
  String landmark;
  String pincode;
  String email;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserModel>(context);

    address = userProvider.address;
    name = userProvider.name;
    landmark = userProvider.landmark;
    pincode = userProvider.pin;
    email = userProvider.email;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            _saveForm();
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
              'Go to Payment',
              15,
              Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    getAppBar(
                      'Personal Details',
                      backArrow(context),
                      Container(),
                      context,
                    ),
                    Form(
                        key: _form,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getBoldText(
                                'Name',
                                13,
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  autocorrect: false,
                                  onSaved: (newValue) {
                                    name = newValue;
                                  },
                                  initialValue: name,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              getBoldText(
                                'Address',
                                13,
                                Colors.black,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: TextFormField(
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  autocorrect: false,
                                  onSaved: (newValue) {
                                    address = newValue;
                                  },
                                  initialValue: address,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // getBoldText(
                              //   'Landmark',
                              //   13,
                              //   Colors.black,
                              // ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // Container(
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(
                              //       15,
                              //     ),
                              //     border: Border.all(
                              //       width: 1,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              //   padding: const EdgeInsets.symmetric(
                              //     horizontal: 20,
                              //   ),
                              //   child: TextFormField(
                              //     decoration: const InputDecoration(
                              //       border: InputBorder.none,
                              //     ),
                              //     autocorrect: false,
                              //     onSaved: (newValue) {
                              //       landmark = newValue;
                              //     },
                              //     initialValue: landmark,
                              //     validator: (value) {
                              //       if (value.isEmpty) {
                              //         return "This field is required";
                              //       }
                              //       return null;
                              //     },
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              getBoldText(
                                'Pin Code',
                                13,
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  autocorrect: false,
                                  onSaved: (newValue) {
                                    pincode = newValue;
                                  },
                                  initialValue: pincode,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // getBoldText(
                              //   'Email ID',
                              //   13,
                              //   Colors.black,
                              // ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // Container(
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(
                              //       15,
                              //     ),
                              //     border: Border.all(
                              //       width: 1,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              //   padding: const EdgeInsets.symmetric(
                              //     horizontal: 20,
                              //   ),
                              //   child: TextFormField(
                              //     decoration: const InputDecoration(
                              //       border: InputBorder.none,
                              //     ),
                              //     autocorrect: false,
                              //     onSaved: (newValue) {
                              //       email = newValue;
                              //     },
                              //     initialValue: email,
                              //     validator: (value) {
                              //       if (value.isEmpty) {
                              //         return "This field is required";
                              //       }
                              //       return null;
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
      ),
    );
  }

  _saveForm() {
    setState(() {
      isLoading = true;
    });
    final isValidate = _form.currentState.validate();
    if (!isValidate) {
      return null;
    }

    _form.currentState.save();
    var userProv = Provider.of<UserModel>(context, listen: false);
    var orderProv = Provider.of<OrderItem>(context, listen: false);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    userProv.setUserId(_auth.currentUser.uid);
    userProv.setNumber(_auth.currentUser.phoneNumber);
    userProv.setName(name);
    userProv.setAddress(address);
    // userProv.setLandmark(landmark);
    userProv.setPin(pincode);
    // userProv.setEmail(email);
    userProv.saveUser(context);
    orderProv.setUserId(_auth.currentUser.uid);
    orderProv.setName(name);
    orderProv.setAddress(address);
    orderProv.setLandmark(landmark);
    orderProv.setPhone(_auth.currentUser.phoneNumber);
    setState(() {
      isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentMethod()),
    );
  }
}
