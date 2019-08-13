import 'package:clock_app/pages/content/stopwatch/digitalStopwatchData.dart';
import 'package:clock_app/pages/content/timer/bottomButtonContent.dart';
import 'package:clock_app/pages/widget/buttonWidget.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> with AutomaticKeepAliveClientMixin<TimerPage> {
  final Dependencies dependencies = new Dependencies();
  List<String> _stopwatchLap = [];
  ScrollController _scrollController = new ScrollController();
  var _txtStyleLap = TextStyle(color: Colors.white, fontSize: 22,);

  @override
  bool get wantKeepAlive => true; 

  void lapButtonPressed() {
    setState(() {
      _stopwatchLap.insert(0, "${dependencies.stopwatch.elapsed.inMinutes}".padLeft(2, '0') + ":" + "${dependencies.stopwatch.elapsed.inSeconds}".padLeft(2, '0') + ":" + "${dependencies.stopwatch.elapsedMilliseconds % 100}".padLeft(2, '0'),);
    });
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void deleteButtonPressed(){
    setState(() {
      dependencies.stopwatch.reset(); 
      _stopwatchLap = []; 
    });
  }

  void runningButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      } else {
        dependencies.stopwatch.start();
      }
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: digitalStopwatchData(dependencies),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    ListView(
                      children: _stopwatchLap.map((item) => Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(item, style: _txtStyleLap,),
                          )
                        ],  
                      )).toList()
                    ),
                  ],  
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: dependencies.stopwatch.isRunning ? buildIconButton(Icons.flag, lapButtonPressed) : SizedBox(),
            ),
            Expanded(
              flex: 4,
              child: FloatinBottomButton(voidCallback: runningButtonPressed,),
            ),
            Expanded(
              flex: 3,
              child: !dependencies.stopwatch.isRunning ? buildFlatButton("Delete", Colors.white, deleteButtonPressed) : SizedBox(),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class TimerText extends StatefulWidget {
  TimerText({this.dependencies});
  final Dependencies dependencies;
  TimerTextState createState() => new TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.dependencies});
  final Dependencies dependencies;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = new Timer.periodic(new Duration(milliseconds: dependencies.timerMillisecondsRefreshRate), callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          new RepaintBoundary(
            child: new Center(
              child: new MinutesAndSeconds(dependencies: dependencies),
            ),
          ),
          new Container(
            child: RepaintBoundary(
            child: new Center(
              child: new Hundreds(dependencies: dependencies),
            ),
          ),
          )
      ],
    ),
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds({this.dependencies});
  final Dependencies dependencies;

  MinutesAndSecondsState createState() => new MinutesAndSecondsState(dependencies: dependencies);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  MinutesAndSecondsState({this.dependencies});
  final Dependencies dependencies;

  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return new Text('$minutesStr:$secondsStr.', style: dependencies.textStyle);
  }
}

class Hundreds extends StatefulWidget {
  Hundreds({this.dependencies});
  final Dependencies dependencies;

  HundredsState createState() => new HundredsState(dependencies: dependencies);
}

class HundredsState extends State<Hundreds> {
  HundredsState({this.dependencies});
  final Dependencies dependencies;

  int hundreds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return new Text(hundredsStr, style: dependencies.textStyle);
  }
}