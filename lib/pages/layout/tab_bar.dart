import 'package:clock_app/pages/content/clock/overview.dart';
import 'package:clock_app/pages/content/stopwatch/stopwatchContent.dart';
import 'package:clock_app/pages/content/timer/overview.dart';
import 'package:flutter/material.dart';

Widget tabBarView(TabController _tabController){
  return AppBar(
    flexibleSpace: Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SafeArea(
        child: getTabBar(_tabController),
      ),
    ),
  );
}

Widget getTabBar(TabController _tabController){
  return TabBar(
    labelColor: Colors.blueAccent,
    unselectedLabelColor: Colors.white,
    indicatorWeight: 2,
    indicatorPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
    indicatorColor: Colors.blueAccent ,
      controller: _tabController,
        tabs: <Widget>[
          Tab(icon: Icon(Icons.access_time, size: 25,), text: 'Clock',),
          Tab(icon: Icon(Icons.hourglass_empty, size: 25,), text: 'Timer',),
          Tab(icon: Icon(Icons.timer, size: 25,), text: 'Stopwatch',),
        ],
  );
}

Widget contentTabBar(){
  return TabBarView(
      children: <Widget>[
        OverviewClockApp(model: null,),
        OverviewTimerApp(),
        TimerPage(),
      ],
    );
}