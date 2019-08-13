import 'package:flutter/material.dart';

Widget buildRefreshButton(double iconSize, VoidCallback callback){
  return new Container(
    margin: EdgeInsets.all(8),
    child: IconButton(
      icon: Icon(Icons.refresh), 
      color: Colors.white, 
      iconSize: iconSize, 
      onPressed: callback,
    )
  );
}

Widget buildFloatingButton(String title, IconData icon, Color color, VoidCallback callback) {
  return new Container(
    child: FittedBox(
    child: FloatingActionButton.extended(
      elevation: 2.0,
      backgroundColor: color,
      onPressed: callback,
      label: Text(title, style: TextStyle(color: Colors.white)),
      icon: Icon(icon, color: Colors.white,),
      ),
    )
  ); 
}

Widget buildFlatButton(String title, Color color, VoidCallback callback) {
  return new Container(
    child: FlatButton(
      child: Text(title, style: TextStyle(color: color), ),
      onPressed: callback,
    ),
  );
}

Widget buildIconButton(IconData iconData, VoidCallback callback){
  return new IconButton(
    icon: Icon(iconData),
    onPressed: callback,
  );
}