import 'package:clock_app/pages/layout/tab_bar.dart';
import 'package:flutter/material.dart';

class ClockHomePage extends StatefulWidget {
  _ClockHomePageState createState() => _ClockHomePageState();
}

class _ClockHomePageState extends State<ClockHomePage> {
  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: tabBarView(_tabController),
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          child: contentTabBar(),
        ),
      ),
    );
  }
}