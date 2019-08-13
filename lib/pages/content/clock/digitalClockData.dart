import 'package:flutter/material.dart';

Container digitalClockData(String digitalClock) {
  return Container(
    child: Center(
      child:  Container(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Text(digitalClock, style: TextStyle(fontSize: 75)),
      ),
    ),
  );
}

Container dateClockData(String _day, String _date, String _month, String _year) {
  return Container(
    child: Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Text(
          _day + ', ' + _date + ' ' + _month + ' ' + _year,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    ),
  );
}