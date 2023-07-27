import 'package:flutter/material.dart';
import 'package:getgodriver/screens/auth/login/login_screen.dart';
import 'package:getgodriver/screens/home/home_screen.dart';
import 'package:getgodriver/screens/setting/settingscreen.dart';
import 'package:getgodriver/screens/user/userScreen.dart';
import 'package:getgodriver/screens/detailedTrip/detailedTripscreen.dart';
import 'package:getgodriver/widgets/appBarSetting.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  bool isOnline = false;
  final List<Map<String, dynamic>> _pages = [
    {
      'page': HomeScreen(),
      'title': 'home',
    },
    {
      'page': UserScreen(),
      'title': 'login',
    },
    {
      'page': SettingScreen(),
      'title': 'setting',
    },
    {
      'page': DetailedTripScreen(),
      'title': "trip",
    }
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarSetting(
            isOnline: isOnline,
            title: "haha"), //_pages[_selectedPageIndex]['title']
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          selectedItemColor: Colors.amber,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'login',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'setting',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.travel_explore),
              label: 'trip',
            ),
          ],
        ),
      ),
    );
  }
}
