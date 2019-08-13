import 'package:clock_app/models/clock_model.dart';
import 'package:clock_app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp(
  model: ClockModel(),
));

class MyApp extends StatelessWidget {
  final ClockModel model;
  const MyApp({Key key, @required this.model}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: model,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark
        ),
        home: ClockHomePage(),
      ),
    );
  }
}