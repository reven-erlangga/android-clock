import 'package:clock_app/pages/content/stopwatch/stopwatchContent.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50, letterSpacing: 5.0);
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}


Container digitalStopwatchData(Dependencies dependencies){
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
                child: TimerText(
                  dependencies: dependencies,
                ),
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
