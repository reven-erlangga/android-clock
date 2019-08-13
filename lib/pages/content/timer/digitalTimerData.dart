import 'package:flutter/material.dart';
import 'dart:ui';

Container digitalTimerData(Duration duration){
  final textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50, letterSpacing: 5.0);
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Container(
          height: 200,
            child: new Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: duration != null ? Text(formatDuration(duration), style: textStyle,) : Text("00:00:00", style: textStyle),
              ),
            ),
          ),
      ],
    ),
  );
}

String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }
  // We want to round up the remaining time to the nearest second
  d += Duration(microseconds: 999999);
  return "${f(d.inHours)}:${f(d.inMinutes%60)}:${f(d.inSeconds%60)}";
}
