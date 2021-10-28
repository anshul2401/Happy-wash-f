import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happy_wash/admin/home.dart';
import 'package:happy_wash/pages/account_page.dart';
import 'package:happy_wash/pages/booking_history.dart';

import 'package:happy_wash/pages/home_page.dart';
import 'package:happy_wash/pages/introscreen/intro_screen.dart';
import 'package:happy_wash/pages/login_screen.dart';
import 'package:happy_wash/pages/menu/about_us.dart';
import 'package:happy_wash/pages/menu/contact_us.dart';
import 'package:happy_wash/pages/menu/faq.dart';
import 'package:happy_wash/pages/menu/gallery.dart';
import 'package:happy_wash/pages/menu/notification.dart';
import 'package:happy_wash/providers/order.dart';
import 'package:happy_wash/providers/packages.dart';
import 'package:happy_wash/providers/user.dart';
import 'package:happy_wash/utils/helper.dart';
import 'package:happy_wash/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_drawer/slide_drawer.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => Packages(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderItem(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(
          backgroundColor: MyColor.primaryColor,
          title: getBoldText('HappyWash', 20, Colors.white),
          seconds: 3,
          navigateAfterSeconds: Splash(),
          useLoader: false,
        ),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      FirebaseAuth.instance.currentUser == null
          ? Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => App()))
          : isAdmin(FirebaseAuth.instance.currentUser.phoneNumber)
              ? Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AdminHomePage()))
              : Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => App()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IntroScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Widget> _widgetList = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getDetails();
    });
    _auth.currentUser == null
        ? _widgetList = [
            const HomePage(),
            const LoginScreen('History'),
            const LoginScreen('Account'),
          ]
        : _widgetList = [
            // App(),
            const HomePage(),
            const BookingHistory(),
            const AccountPage(),
          ];

    super.initState();
  }

  getDetails() async {
    var userProvider = Provider.of<UserModel>(context, listen: false);
    final FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.currentUser == null
        ? null
        : await userProvider.setUserId(_auth.currentUser.uid);
    _auth.currentUser == null
        ? null
        : await userProvider.setNumber(_auth.currentUser.phoneNumber);
    _auth.currentUser == null ? null : await userProvider.fetchUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.storefront_outlined,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today,
              ),
              label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: 'Account',
          ),
        ],
        selectedItemColor: MyColor.primaryColor,
        currentIndex: _index,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: _widgetList[_index],
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SlideDrawer(
        headDrawer: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getBoldText('HappyWash', 20, Colors.white),
              getNormalText(
                'Full car wash service',
                15,
                Colors.white,
              )
            ],
          )),
        ),
        alignment: SlideDrawerAlignment.center,
        backgroundColor: MyColor.primaryColor,
        items: [
          MenuItem('Gallery', onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Gallery()));
          }, icon: Icons.photo_album),
          MenuItem('Notifications', onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Notifications()));
          }, icon: Icons.notifications),
          MenuItem('About us', onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutUs()));
          }, icon: Icons.info),
          MenuItem('FAQ', onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const FAQ()));
          }, icon: Icons.question_answer),
          MenuItem('Contact us', onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ContactUS()));
          }, icon: Icons.headphones),
          MenuItem('Log out', onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => App()));
          }, icon: Icons.logout),
        ],
        child: const BottomNavBar(),
      ),
    );
  }
}
