import 'package:flutter/material.dart';
import 'package:happy_wash/pages/date_time.dart';
import 'package:happy_wash/providers/order.dart';
import 'package:happy_wash/providers/package.dart';
import 'package:happy_wash/providers/packages.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:provider/provider.dart';

class ChoosePackage extends StatefulWidget {
  final String carType;
  const ChoosePackage({
    Key key,
    this.carType,
  }) : super(key: key);

  @override
  _ChoosePackageState createState() => _ChoosePackageState();
}

class _ChoosePackageState extends State<ChoosePackage> {
  bool isRegularPackage = true;
  bool isMonthlyPackage = false;

  @override
  Widget build(BuildContext context) {
    var packageProvider = Provider.of<Packages>(context);
    List<Package> packages = packageProvider.packages;
    var _regularPackages =
        packages.where((val) => val.type == 'Regular').toList();
    var _monthlyPackages =
        packages.where((val) => val.type == 'Monthly').toList();
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            var packageProvider = Provider.of<Packages>(context, listen: false);
            var packagess = packageProvider.getCartItem();
            List<String> packages = [];
            for (var element in packagess) {
              packages?.add(element.title);
            }
            var orderItemProvider =
                Provider.of<OrderItem>(context, listen: false);

            orderItemProvider.setPackage(packages);

            packages.isEmpty
                ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please select package'),
                  ))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DateTimePicker()),
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
              'Continue to Date & Time',
              15,
              Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            getAppBar(
              'Choose Package',
              backArrow(context),
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
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isRegularPackage = true;
                          isMonthlyPackage = false;
                        });
                      },
                      child: Container(
                        height: 49.5,
                        width: MediaQuery.of(context).size.width / 2 - 17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          color: isRegularPackage
                              ? MyColor.primaryColor
                              : Colors.transparent,
                        ),
                        alignment: Alignment.center,
                        child: getNormalText(
                          'Regular Package',
                          15,
                          isRegularPackage ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isRegularPackage = false;
                          isMonthlyPackage = true;
                        });
                      },
                      child: Container(
                        height: 49.5,
                        width: MediaQuery.of(context).size.width / 2 - 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          color: isMonthlyPackage
                              ? MyColor.primaryColor
                              : Colors.transparent,
                        ),
                        alignment: Alignment.center,
                        child: getNormalText(
                          'Monthly Package',
                          15,
                          isMonthlyPackage ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: isRegularPackage
                      ? _regularPackages.length
                      : _monthlyPackages.length,
                  itemBuilder: (context, index) {
                    var data =
                        isRegularPackage ? _regularPackages : _monthlyPackages;
                    return getCard(data[index]);
                  }),
            ),
          ],
        ),
      ),
    ));
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
                            GestureDetector(
                              onTap: () {
                                Provider.of<Packages>(context, listen: false)
                                    .toggleViewMore(package);
                              },
                              child: getNormalText(
                                package.isShowMore
                                    ? 'Less Details'
                                    : 'View more details',
                                14,
                                MyColor.primaryColor,
                              ),
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
          package.isShowMore
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: package.description.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            top: 5,
                          ),
                          child: getNormalText(
                            package.description[index],
                            15,
                            Colors.grey,
                          ),
                        );
                      }),
                )
              : Container()
        ],
      ),
    );
  }
}
