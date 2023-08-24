import 'package:flutter/material.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/screens/auth/login/login_screen.dart';
import 'package:getgodriver/screens/history/history_screen.dart';
import 'package:getgodriver/screens/home/home_screen.dart';
import 'package:getgodriver/screens/scheduledTrips/scheduledTrips_screen.dart';
import 'package:getgodriver/screens/setting/settingscreen.dart';
import 'package:getgodriver/screens/user/userScreen.dart';
import 'package:getgodriver/screens/detailedTrip/detailedTripScreen.dart';
import 'package:getgodriver/widgets/appBarSetting.dart';
import 'package:provider/provider.dart';

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
      'page': HistoryScreen(),
      'title': "history",
    },
    {
      'page': SettingScreen(),
      'title': 'setting',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SocketService.connectserver(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarSetting(), //_pages[_selectedPageIndex]['title']
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: _selectPage,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'history',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'setting',
            ),
          ],
        ),
      ),
    );
  }
}
