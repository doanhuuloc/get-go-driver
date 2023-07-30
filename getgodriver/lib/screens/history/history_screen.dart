import 'package:flutter/material.dart';
import 'package:getgodriver/widgets/history/historyTab.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: themeData.primaryColor,
          
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
            Tab(
              child: Text("Ngày", style: themeData.textTheme.titleMedium,),
            ),
            Tab(
              child: Text("Tuần", style: themeData.textTheme.titleMedium),
            ),
            Tab(
              child: Text("Tháng", style: themeData.textTheme.titleMedium),
            ),
          ]),
        ),
        body: const TabBarView(children: [
          HistoryTab(
            type: 'day',
            data: [],
          ),
          HistoryTab(
            type: 'week',
            data: [],
          ),
          HistoryTab(
            type: 'month',
            data: [],
          ),
        ]),
      ),
    ));
  }
}

