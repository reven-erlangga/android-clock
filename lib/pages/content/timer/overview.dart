import 'package:clock_app/models/clock_model.dart';
import 'package:clock_app/pages/content/timer/bottomButtonContent.dart';
import 'package:clock_app/pages/content/timer/digitalTimerData.dart';
import 'package:clock_app/pages/widget/buttonWidget.dart';
import 'package:countdown/countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:scoped_model/scoped_model.dart';

class OverviewTimerApp extends StatefulWidget {
  _OverviewTimerAppState createState() => _OverviewTimerAppState();
  CountDown _countDown;
}

class _OverviewTimerAppState extends State<OverviewTimerApp> with AutomaticKeepAliveClientMixin {
  bool isStarted = false, isPlay = false, isDelete = false, isReset = false;
  int _hour=0,_minutes=0,_second=0;
  Duration _duration;
  var _titleTextStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22);
  var sub;
  
  @override
  bool get wantKeepAlive => true; 

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onStartStopPress() {
    if(this.sub == null){
      sub = widget._countDown.stream.listen(null);
      sub.onData((_duration){
        setState((){
          this._duration = _duration;
        });
      });
      sub.onDone((){
        print("done");
        setState((){
          this._duration = Duration(seconds: _second);
          this.sub = null;
          this.isStarted = false;
          this.isPlay = false;
        });
      });
    } else {
      if(this.isDelete){
        sub.cancel();
        setState((){
          this._duration = Duration(seconds: _second);
          this.sub = null;
          this.isDelete = false;
          this.isStarted = true;
          this.isPlay = false;
        });
      } else if (this.isReset){
        if(isReset){
          setState(() {
            sub.cancel();
            this.sub = null;
            this.isPlay = false;
            this.isReset = false;
            this.isStarted = true;
            widget._countDown = new CountDown(new Duration(hours: _hour, minutes: _minutes, seconds: _second)); 
            isPlay = true;
          });
        }
        setStartOrStop();
        } else if (!this.isStarted) {
          sub.resume();
        } else if (this.isStarted) {
          print(this.isStarted);
        sub.pause();
      }
    }
    setState((){
      this.isStarted = !this.isStarted;
    });
  }

  pickerNumber() {
    setState(() {
      showPickerNumber(context);
    });
  }

  setStartOrStop() {
    setState(() {
      onStartStopPress();
    });
  }

  setDelete(){
    setState(() {
      this.isDelete = true;
      print(this.isStarted);
      onStartStopPress(); 
    });
  }

  setReset(){
    setState(() {
     this.isReset = true;
     this.isPlay = true;
      onStartStopPress();   
    });
  }

@override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ClockModel> (
      builder: (BuildContext context, Widget widget, ClockModel model) => Scaffold(
        body: digitalTimerData(_duration),
        floatingActionButton: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: isPlay ? buildFlatButton("Delete", Colors.white, setDelete) : SizedBox()
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: !isPlay ? buildFloatingButton("Set Timer", Icons.timer, Colors.blueAccent, pickerNumber) : FloatinBottomButton(voidCallback: setStartOrStop, parameter: "Timer",) ,
                  )
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: isStarted && isPlay ? buildFlatButton("Reset", Colors.white, setReset) : SizedBox(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      )
    );
  }

  showPickerNumber(BuildContext context) {
    new Picker(
      changeToFirst: false,
      hideHeader: false,
      headerDecoration: BoxDecoration(
        color: Colors.black38,
      ),
      backgroundColor: Color.fromARGB(255, 48, 48, 48),
      title: Text( "Set Timer", style:_titleTextStyle ),
      textStyle: TextStyle(color: Colors.white, fontSize: 18, wordSpacing: 2),
      selectedTextStyle: TextStyle(color: Colors.blue, fontSize: 28),
      confirmTextStyle: TextStyle(color: Colors.blue, fontSize: 20),
      cancelTextStyle: TextStyle(color: Colors.red, fontSize: 20),
      adapter: NumberPickerAdapter(data: [
        NumberPickerColumn(begin: 0, end: 23, ),
        NumberPickerColumn(begin: 0, end: 59),
      ]),
      delimiter: [
        PickerDelimiter(
          column: 1,
          child: Container(
            width: 80.0,
            alignment: Alignment.center,
            child: Text("Hours"),
          )
        ),
        PickerDelimiter(
          column: 4,
          child: Container(
            width: 80.0,
            alignment: Alignment.center,
            child: Text('Minutes'),
          )
        ),
      ],
      onConfirm: (Picker picker, List value) {
        setState(() {
          _hour = (picker.getSelectedValues().elementAt(0));
          _minutes = (picker.getSelectedValues().elementAt(1));
          widget._countDown = new CountDown(new Duration(hours: _hour, minutes: _minutes, seconds: _second)); 
          isPlay = true;
          onStartStopPress();
        });
      }
    ).showModal(this.context);
  }
}