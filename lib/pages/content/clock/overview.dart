import 'dart:async';

import 'package:clock_app/models/clock_model.dart';
import 'package:clock_app/pages/content/clock/analogClockData.dart';
import 'package:clock_app/pages/content/clock/digitalClockData.dart';
import 'package:clock_app/pages/widget/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Depedencies {
  static DateTime _currentTime;
  static Timer _timer;
  static String _date = '-', _year = '-';
}

class OverviewClockApp extends StatefulWidget{
  @override
  _OverviewClockAppState createState() => _OverviewClockAppState();
  final ClockModel model;
  const OverviewClockApp({Key key, @required this.model}) : super(key: key);
}

class _OverviewClockAppState extends State<OverviewClockApp> {
   
  @override
  void initState() {
    super.initState();
    Depedencies._currentTime = DateTime.now();
    Depedencies._timer = Timer.periodic(Duration(seconds: 1), _onTimeChange);
  }

  @override
  void dispose() {
    Depedencies._timer.cancel();
    super.dispose();
  }

  void _onTimeChange(Timer timer) {
    setState(() {
      ClockModel modelContext = (ScopedModel.of(context));
      modelContext.getDayString();
      Depedencies._date = DateTime.now().day.toString();
      Depedencies._year = DateTime.now().year.toString();
      modelContext.getMonthString();
      Depedencies._currentTime = DateTime.now();
    });
  }

  void _onRefreshData(){
    setState(() {
      ClockModel modelContext = (ScopedModel.of(context));
      modelContext.getDayString();
      Depedencies._date = DateTime.now().day.toString();
      Depedencies._year = DateTime.now().year.toString();
      modelContext.getMonthString();
      Depedencies._currentTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hours = Depedencies._currentTime.hour;
    final minutes = Depedencies._currentTime.minute;
    final digitalClock = '$hours'.toString().padLeft(2, '0') + ' : ' + '$minutes'.toString().padLeft(2, '0');

    return Scaffold(
      body: ScopedModelDescendant <ClockModel> (
        builder: (BuildContext context, Widget widget, ClockModel model) =>  Container(
          child:  Container(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 250,
                      child: Center(
                        child: analogClockData()
                      )
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          buildRefreshButton(42.0, _onRefreshData),
                          digitalClockData(digitalClock),
                          dateClockData(model.dayString, Depedencies._date, model.monthString, Depedencies._year)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        )
      )   
    );
  }
}

Widget buildFloatingButton(VoidCallback callback) {
  return new Container(
    height: 80.0,
    width: 150.0,
    child: FittedBox(
    child: FloatingActionButton.extended(
      label: Text('data'),
      elevation: 5.0,
      onPressed: callback
      ),
    )
  ); 
}