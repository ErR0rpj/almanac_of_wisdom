import 'dart:io';
import 'package:almanac_of_wisdom/constants/colors.dart';
import 'package:almanac_of_wisdom/firebase_options.dart';
import 'package:almanac_of_wisdom/screens/category_page.dart';
import 'package:almanac_of_wisdom/screens/home_page.dart';
import 'package:almanac_of_wisdom/screens/profile_page.dart';
import 'package:almanac_of_wisdom/screens/saved_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //FIrebase initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //This is for Web view
  if (Platform.isAndroid) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Almanac Of Wisdom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(observer),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.observer, {super.key});

  final FirebaseAnalyticsObserver observer;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _currentBottomNavigationIndex = 0;

  List<Widget> _bottomNavigationPage() {
    return [
      HomePage(widget.observer),
      const CategoryPage(),
      const SavedPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavigationPage()[_currentBottomNavigationIndex],
      //Commented bottom navigation for v1.0.0.
      // body: _bottomNavigationPage[_currentBottomNavigationIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentBottomNavigationIndex,
      //   showSelectedLabels: true,
      //   showUnselectedLabels: false,
      //   selectedItemColor: AppColors.secondaryColor,
      //   unselectedItemColor: AppColors.tertiaryColor,
      //   selectedLabelStyle: GoogleFonts.lato(),
      //   unselectedLabelStyle: GoogleFonts.lato(),
      //   elevation: 10,
      //   onTap: (index) {
      //     setState(() {
      //       _currentBottomNavigationIndex = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         IconlyLight.home,
      //       ),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         IconlyLight.category,
      //       ),
      //       label: 'Categories',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         IconlyLight.bookmark,
      //       ),
      //       label: 'Saved',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         IconlyLight.profile,
      //       ),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}
