import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';

AnalogClock analogClockData(){
  return AnalogClock(
    decoration: BoxDecoration(
      color: Colors.transparent,
    ),
    isLive: true,
    numberColor: Colors.white,
    hourHandColor: Colors.white,
    minuteHandColor: Colors.white,
    secondHandColor: Colors.red,
    tickColor: Colors.white,
    showSecondHand: true,
    showNumbers: true,
    textScaleFactor: 1.8,
    showTicks: true,
    showDigitalClock: false,
  );
}