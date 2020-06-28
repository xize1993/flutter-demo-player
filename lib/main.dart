import 'package:flutter/material.dart';
import 'package:flutter_player_demo/page/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Player Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        backgroundColor: Colors.white
      ),
      home: HomePageWidget()
    );
  }
}

