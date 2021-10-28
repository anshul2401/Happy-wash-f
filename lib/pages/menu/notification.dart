import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              getAppBar(
                  'Notifications', backArrow(context), Container(), context),
              // Container(
              //   padding: EdgeInsets.all(8),
              //   width: double.infinity,
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 50,
              //         width: 50,
              //         decoration: BoxDecoration(
              //           color: MyColor.primaryColor,
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //         child: Icon(
              //           Icons.mail,
              //           color: Colors.white,
              //         ),
              //       ),
              //       Flexible(
              //         child: Container(
              //           // width: double.infinity,
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             'This  os some random text toh thifj ajkfhk hadhjdhs hd ahjhd z',
              //             softWrap: true,
              //             textAlign: TextAlign.justify,
              //             style: GoogleFonts.varelaRound(
              //               textStyle: TextStyle(
              //                 fontSize: 13,
              //                 color: Colors.grey,
              //               ),
              //             ),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
