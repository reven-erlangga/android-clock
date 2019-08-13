import 'package:flutter/material.dart';

class FloatinBottomButton extends StatefulWidget {
  final VoidCallback voidCallback;
  final String parameter;
  const FloatinBottomButton({Key key, this.voidCallback, this.parameter}) : super(key: key);

  @override
  _FloatinBottomButtonState createState() => _FloatinBottomButtonState();
}

class _FloatinBottomButtonState extends State<FloatinBottomButton> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  AnimatedIconData _animateIconString;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;
  String _titleFab;

  @override
  initState() {
    if(widget.parameter == "Timer"){
      _titleFab = "Stop";
      _animateIconString = AnimatedIcons.pause_play;
    } else {
      _titleFab = "Start";
      _animateIconString = AnimatedIcons.play_pause;
    }
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: widget.parameter == "Timer" ? Colors.redAccent : Colors.lightBlue,
      end:  widget.parameter == "Timer" ? Colors.lightBlue : Colors.redAccent,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
      if (widget.parameter == "Timer"){
      _titleFab = "Start";
      } else {
        
      _titleFab = "Pause";
      }
    } else {
      _animationController.reverse();
      if (widget.parameter == "Timer"){
        _titleFab = "Pause";
      } else { 
      _titleFab = "Start";
      }
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return Container(
      width: 120,
      child:  FloatingActionButton.extended(
      backgroundColor: _animateColor.value,
      onPressed: (){
        widget.voidCallback();
        animate();
        } ,
      tooltip: 'Start Pause',
      label: Text(_titleFab,),
      icon: AnimatedIcon(
        size: 30,
        icon: _animateIconString,
        progress: _animateIcon,
      ),
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}