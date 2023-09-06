import 'package:almanac_of_wisdom/constants/colors.dart';
import 'package:almanac_of_wisdom/screens/category_page.dart';
import 'package:almanac_of_wisdom/screens/home_page.dart';
import 'package:almanac_of_wisdom/screens/profile_page.dart';
import 'package:almanac_of_wisdom/screens/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Almanac Of Wisdom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentBottomNavigationIndex = 0;
  final List<Widget> _bottomNavigationPage = [
    const HomePage(),
    const CategoryPage(),
    const SavedPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavigationPage[_currentBottomNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomNavigationIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.secondaryColor,
        unselectedItemColor: AppColors.tertiaryColor,
        selectedLabelStyle: GoogleFonts.lato(),
        unselectedLabelStyle: GoogleFonts.lato(),
        elevation: 10,
        onTap: (index) {
          setState(() {
            _currentBottomNavigationIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              IconlyLight.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconlyLight.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconlyLight.bookmark,
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconlyLight.profile,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
