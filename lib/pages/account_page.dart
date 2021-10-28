import 'package:flutter/material.dart';
import 'package:happy_wash/providers/user.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:slide_drawer/slide_drawer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _form = GlobalKey<FormState>();
  String address;
  String name;
  String mobile;
  String email;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserModel>(context);

    address = userProvider.address;
    name = userProvider.name;

    email = userProvider.email;
    mobile = userProvider.number;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getAppBar(
                'Profile',
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
                padding: const EdgeInsets.all(8),
                child: getBoldText('Account', 15, Colors.black),
              ),
              Form(
                  key: _form,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
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
                        getBoldText(
                          'Email ID',
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
                              email = newValue;
                            },
                            initialValue: email,
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
                          'Mobile',
                          13,
                          Colors.black,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        getNormalText(mobile, 15, Colors.black),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _saveForm(context);
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
                              'Save',
                              15,
                              Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _saveForm(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    final isValidate = _form.currentState.validate();
    if (!isValidate) {
      return null;
    }

    _form.currentState.save();
    var userProv = Provider.of<UserModel>(context, listen: false);

    userProv.setName(name);
    userProv.setAddress(address);

    userProv.setEmail(email);
    userProv.saveUser(context);

    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Updated successfully'),
    ));
  }
}
